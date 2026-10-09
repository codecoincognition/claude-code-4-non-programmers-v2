#!/usr/bin/env node
// whatsapp — a custom Claude Code channel for WhatsApp, using Twilio as the
// inbound webhook receiver and outbound sender.
//
// How it works (see Chapter 13 and https://code.claude.com/docs/en/channels-reference):
//   - Claude Code starts this file as an MCP server over stdio.
//   - The server also listens on a local HTTP port (127.0.0.1 only). Twilio
//     calls a public HTTPS URL that you forward to that port with a tunnel
//     (for example cloudflared or ngrok).
//   - Every request must carry a valid X-Twilio-Signature. Unsigned or forged
//     requests are rejected before anything else happens.
//   - A message from a phone number on the allowlist is pushed into the
//     session as <channel source="whatsapp" chat_id="+1..." ...>. Everything
//     else is dropped silently.
//   - Claude answers with the `reply` tool. During quiet hours (for example
//     22:00-07:00) replies are held unless the incoming message contained the
//     urgent word (URGENT by default).
//   - Optional permission relay: tool-approval prompts go to the numbers in
//     "relayTo", who answer "yes <id>" or "no <id>".
//
// Config lives outside the repo, next to the official channel plugins:
//   ~/.claude/channels/whatsapp/.env         TWILIO_* settings and PUBLIC_URL
//   ~/.claude/channels/whatsapp/access.json  allowFrom, relayTo, quietHours, urgentWord
// access.json is re-read on every message, so edits apply at once.

import { createHmac, timingSafeEqual } from "node:crypto";
import { readFileSync } from "node:fs";
import http from "node:http";
import os from "node:os";
import path from "node:path";
import { z } from "zod";
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

// ---------------------------------------------------------------- config

const STATE_DIR =
  process.env.WHATSAPP_STATE_DIR ??
  path.join(os.homedir(), ".claude", "channels", "whatsapp");
const ACCESS_FILE = path.join(STATE_DIR, "access.json");

// Load ~/.claude/channels/whatsapp/.env into process.env. Real env wins.
function loadEnvFile(file: string): void {
  let raw: string;
  try {
    raw = readFileSync(file, "utf8");
  } catch {
    return;
  }
  for (const line of raw.split(/\r?\n/)) {
    const m = /^\s*([A-Z0-9_]+)\s*=\s*(.*?)\s*$/.exec(line);
    if (!m || line.trimStart().startsWith("#")) continue;
    const value = m[2].replace(/^(['"])(.*)\1$/, "$2");
    if (process.env[m[1]] === undefined) process.env[m[1]] = value;
  }
}
loadEnvFile(path.join(STATE_DIR, ".env"));

const ACCOUNT_SID = process.env.TWILIO_ACCOUNT_SID ?? "";
const AUTH_TOKEN = process.env.TWILIO_AUTH_TOKEN ?? "";
const FROM_NUMBER = process.env.TWILIO_WHATSAPP_FROM ?? ""; // your Twilio WhatsApp sender, e.g. +14155238886
const PUBLIC_URL = process.env.PUBLIC_URL ?? ""; // the exact URL Twilio calls, e.g. https://xyz.trycloudflare.com/whatsapp
const PORT = Number(process.env.PORT ?? "8790");
const TWILIO_API_URL = (process.env.TWILIO_API_URL ?? "https://api.twilio.com").replace(/\/$/, "");

function log(msg: string): void {
  // stdout is the MCP transport; all logging goes to stderr.
  process.stderr.write(`[whatsapp] ${msg}\n`);
}

const missing = Object.entries({ TWILIO_ACCOUNT_SID: ACCOUNT_SID, TWILIO_AUTH_TOKEN: AUTH_TOKEN, TWILIO_WHATSAPP_FROM: FROM_NUMBER, PUBLIC_URL })
  .filter(([, v]) => !v)
  .map(([k]) => k);
if (missing.length) {
  log(`missing ${missing.join(", ")} (looked in ${path.join(STATE_DIR, ".env")})`);
  process.exit(1);
}

// Phone numbers in +country format, e.g. +15550123.
const PHONE = /^\+[1-9][0-9]{6,15}$/;
const HHMM = /^([01][0-9]|2[0-3]):[0-5][0-9]$/;

type Access = {
  allowFrom: string[];
  relayTo: string[];
  quietHours: { start: string; end: string } | null;
  urgentWord: string;
};

function readAccess(): Access {
  try {
    const p = JSON.parse(readFileSync(ACCESS_FILE, "utf8"));
    const phones = (v: unknown) =>
      Array.isArray(v) ? v.filter((x): x is string => typeof x === "string" && PHONE.test(x)) : [];
    const allowFrom = phones(p.allowFrom);
    const relayTo = phones(p.relayTo).filter((n) => allowFrom.includes(n));
    const q = p.quietHours;
    const quietHours =
      q && typeof q.start === "string" && typeof q.end === "string" && HHMM.test(q.start) && HHMM.test(q.end)
        ? { start: q.start, end: q.end }
        : null;
    const urgentWord = typeof p.urgentWord === "string" && p.urgentWord.trim() ? p.urgentWord.trim() : "URGENT";
    return { allowFrom, relayTo, quietHours, urgentWord };
  } catch {
    return { allowFrom: [], relayTo: [], quietHours: null, urgentWord: "URGENT" }; // fail closed
  }
}

const relayAtBoot = readAccess().relayTo.length > 0;

// ---------------------------------------------------------------- helpers

const minutes = (hhmm: string) => Number(hhmm.slice(0, 2)) * 60 + Number(hhmm.slice(3, 5));

// True if `now` (local time on this machine) falls inside the quiet window.
// Windows may wrap midnight, e.g. 22:00-07:00.
function inQuietHours(q: Access["quietHours"], now = new Date()): boolean {
  if (!q) return false;
  const t = now.getHours() * 60 + now.getMinutes();
  const s = minutes(q.start);
  const e = minutes(q.end);
  if (s === e) return false;
  return s < e ? t >= s && t < e : t >= s || t < e;
}

function containsWord(text: string, word: string): boolean {
  const escaped = word.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return new RegExp(`(^|[^A-Za-z0-9])${escaped}([^A-Za-z0-9]|$)`).test(text);
}

// Twilio request validation: HMAC-SHA1 over the full URL plus every POST
// parameter (sorted by name, name+value concatenated), keyed by the auth token.
function validTwilioSignature(signature: string, params: URLSearchParams): boolean {
  const keys = [...new Set(params.keys())].sort();
  let data = PUBLIC_URL;
  for (const k of keys) for (const v of params.getAll(k)) data += k + v;
  const expected = createHmac("sha1", AUTH_TOKEN).update(data, "utf8").digest("base64");
  const a = Buffer.from(expected);
  const b = Buffer.from(signature);
  return a.length === b.length && timingSafeEqual(a, b);
}

// WhatsApp bodies over 1600 characters are rejected by Twilio; split them.
function chunk(text: string, size = 1500): string[] {
  const out: string[] = [];
  for (let i = 0; i < text.length; i += size) out.push(text.slice(i, i + size));
  return out;
}

async function sendWhatsApp(to: string, body: string): Promise<{ ok: boolean; error?: string }> {
  for (const part of chunk(body)) {
    const res = await fetch(`${TWILIO_API_URL}/2010-04-01/Accounts/${ACCOUNT_SID}/Messages.json`, {
      method: "POST",
      headers: {
        Authorization: "Basic " + Buffer.from(`${ACCOUNT_SID}:${AUTH_TOKEN}`).toString("base64"),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({ From: `whatsapp:${FROM_NUMBER}`, To: `whatsapp:${to}`, Body: part }),
    });
    if (!res.ok) {
      let detail = `HTTP ${res.status}`;
      try {
        const j = (await res.json()) as { code?: number; message?: string };
        detail = `Twilio error ${j.code ?? res.status}: ${j.message ?? "unknown"}`;
      } catch {}
      return { ok: false, error: detail };
    }
  }
  return { ok: true };
}

// ---------------------------------------------------------------- MCP server

const mcp = new Server(
  { name: "whatsapp", version: "1.0.0" },
  {
    capabilities: {
      experimental: {
        "claude/channel": {},
        ...(relayAtBoot ? { "claude/channel/permission": {} } : {}),
      },
      tools: {},
    },
    instructions:
      'WhatsApp messages arrive as <channel source="whatsapp" chat_id="+..." sender="+..." urgent="true|false" quiet_hours="true|false">. ' +
      "Only allowlisted numbers can reach you. Answer with the reply tool, passing the chat_id from the tag. " +
      'When quiet_hours="true" and urgent="false", the reply tool will hold the reply: do not retry; ' +
      "note the message for the morning instead. Your terminal output is not visible to the sender.",
  },
);

// Last inbound message per chat: was it urgent? Used for the quiet-hours rule.
const lastUrgent = new Map<string, boolean>();

mcp.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "reply",
      description: "Send a WhatsApp message back to the number the request came from",
      inputSchema: {
        type: "object",
        properties: {
          chat_id: { type: "string", description: "The chat_id from the <channel> tag (a +country phone number)" },
          text: { type: "string", description: "The message to send (plain text)" },
        },
        required: ["chat_id", "text"],
      },
    },
  ],
}));

mcp.setRequestHandler(CallToolRequestSchema, async (req) => {
  if (req.params.name !== "reply") throw new Error(`unknown tool: ${req.params.name}`);
  const args = (req.params.arguments ?? {}) as { chat_id?: unknown; text?: unknown };
  const chat_id = typeof args.chat_id === "string" ? args.chat_id : "";
  const text = typeof args.text === "string" ? args.text : "";
  const access = readAccess();
  if (!access.allowFrom.includes(chat_id)) {
    return { isError: true, content: [{ type: "text", text: `refused: ${chat_id || "(empty)"} is not on the allowlist` }] };
  }
  if (!text.trim()) {
    return { isError: true, content: [{ type: "text", text: "refused: empty message" }] };
  }
  if (inQuietHours(access.quietHours) && !lastUrgent.get(chat_id)) {
    const q = access.quietHours!;
    return {
      isError: true,
      content: [{ type: "text", text: `not sent: quiet hours ${q.start}-${q.end} and the message did not contain ${access.urgentWord}` }],
    };
  }
  const result = await sendWhatsApp(chat_id, text);
  if (!result.ok) return { isError: true, content: [{ type: "text", text: `not sent: ${result.error}` }] };
  return { content: [{ type: "text", text: "sent" }] };
});

const PermissionRequestSchema = z.object({
  method: z.literal("notifications/claude/channel/permission_request"),
  params: z.object({
    request_id: z.string(),
    tool_name: z.string(),
    description: z.string(),
    input_preview: z.string(),
  }),
});

// Permission prompts ignore quiet hours: Claude is waiting on the answer.
mcp.setNotificationHandler(PermissionRequestSchema, async ({ params }) => {
  const prompt =
    `Claude wants to run ${params.tool_name}: ${params.description}\n` +
    `${params.input_preview}\n\n` +
    `Reply "yes ${params.request_id}" or "no ${params.request_id}"`;
  for (const to of readAccess().relayTo) {
    const r = await sendWhatsApp(to, prompt);
    if (!r.ok) log(`could not relay permission prompt to ${to}: ${r.error}`);
  }
});

// ---------------------------------------------------------------- inbound webhook

const PERMISSION_REPLY_RE = /^\s*(y|yes|n|no)\s+([a-km-z]{5})\s*$/i;
const EMPTY_TWIML = '<?xml version="1.0" encoding="UTF-8"?><Response></Response>';
const WEBHOOK_PATH = new URL(PUBLIC_URL).pathname || "/";

async function handleInbound(params: URLSearchParams): Promise<void> {
  const from = (params.get("From") ?? "").replace(/^whatsapp:/, "");
  const body = params.get("Body") ?? "";
  const access = readAccess();

  // Gate on the sender's number.
  if (!access.allowFrom.includes(from)) {
    log(`dropped message from non-allowlisted number ${from || "(none)"}`);
    return;
  }

  const verdict = PERMISSION_REPLY_RE.exec(body);
  if (verdict && relayAtBoot && access.relayTo.includes(from)) {
    await mcp.notification({
      method: "notifications/claude/channel/permission",
      params: {
        request_id: verdict[2].toLowerCase(),
        behavior: verdict[1].toLowerCase().startsWith("y") ? "allow" : "deny",
      },
    });
    return;
  }

  const media = Number(params.get("NumMedia") ?? "0");
  const content = media > 0 ? `${body}\n[${media} attachment(s) not shown]` : body;
  const urgent = containsWord(body, access.urgentWord);
  lastUrgent.set(from, urgent);

  await mcp.notification({
    method: "notifications/claude/channel",
    params: {
      content,
      meta: {
        chat_id: from,
        sender: from,
        profile_name: params.get("ProfileName") ?? "",
        message_sid: params.get("MessageSid") ?? "",
        urgent: String(urgent),
        quiet_hours: String(inQuietHours(access.quietHours)),
      },
    },
  });
}

await mcp.connect(new StdioServerTransport());

const httpServer = http.createServer(async (req, res) => {
  const url = new URL(req.url ?? "/", "http://localhost");
  if (req.method !== "POST" || url.pathname !== WEBHOOK_PATH) {
    res.writeHead(404).end();
    return;
  }
  let raw = "";
  let tooBig = false;
  for await (const c of req) {
    raw += c;
    if (raw.length > 64 * 1024) { tooBig = true; break; }
  }
  if (tooBig) { res.writeHead(413).end(); return; }
  const params = new URLSearchParams(raw);
  const signature = String(req.headers["x-twilio-signature"] ?? "");
  if (!signature || !validTwilioSignature(signature, params)) {
    log("rejected request with a missing or invalid X-Twilio-Signature");
    res.writeHead(403).end("forbidden");
    return;
  }
  try {
    await handleInbound(params);
  } catch (err) {
    log(`error handling message: ${String(err)}`);
  }
  // Empty TwiML: we reply later through the API, not in the webhook response.
  res.writeHead(200, { "Content-Type": "text/xml" }).end(EMPTY_TWIML);
});

httpServer.listen(PORT, "127.0.0.1", () => {
  log(`listening on 127.0.0.1:${PORT}${WEBHOOK_PATH}; ${readAccess().allowFrom.length} allowlisted number(s); permission relay ${relayAtBoot ? "on" : "off"}`);
});
