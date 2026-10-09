#!/usr/bin/env node
// slack-dm — a custom Claude Code channel that lets allowlisted people DM
// a Slack app and have the message land in a running Claude Code session.
//
// How it works (see Chapter 13 and https://code.claude.com/docs/en/channels-reference):
//   - Claude Code starts this file as an MCP server over stdio.
//   - The server opens a Slack Socket Mode connection (outbound websocket,
//     no public URL needed) and listens for direct messages to the app.
//   - A DM from a Slack user ID on the allowlist is pushed into the session
//     as a <channel source="slack-dm" chat_id="..." user="..."> event.
//     Everything else is dropped silently, before Claude ever sees it.
//   - Claude answers with the `reply` tool, which posts back into the DM.
//   - Optional permission relay: tool-approval prompts are sent to the Slack
//     users listed in "relayTo", who answer "yes <id>" or "no <id>".
//
// Config lives outside the repo, next to the official channel plugins:
//   ~/.claude/channels/slack-dm/.env         SLACK_APP_TOKEN, SLACK_BOT_TOKEN
//   ~/.claude/channels/slack-dm/access.json  {"allowFrom": [...], "relayTo": [...]}
// access.json is re-read on every message, so allowlist edits apply at once.

import { readFileSync } from "node:fs";
import os from "node:os";
import path from "node:path";
import { z } from "zod";
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { SocketModeClient, LogLevel } from "@slack/socket-mode";
import { WebClient } from "@slack/web-api";

// ---------------------------------------------------------------- config

const STATE_DIR =
  process.env.SLACK_DM_STATE_DIR ??
  path.join(os.homedir(), ".claude", "channels", "slack-dm");
const ACCESS_FILE = path.join(STATE_DIR, "access.json");

// Load ~/.claude/channels/slack-dm/.env into process.env. Real env wins.
function loadEnvFile(file: string): void {
  let raw: string;
  try {
    raw = readFileSync(file, "utf8");
  } catch {
    return; // no .env file is fine if the variables are already set
  }
  for (const line of raw.split(/\r?\n/)) {
    const m = /^\s*([A-Z0-9_]+)\s*=\s*(.*?)\s*$/.exec(line);
    if (!m || line.trimStart().startsWith("#")) continue;
    const value = m[2].replace(/^(['"])(.*)\1$/, "$2");
    if (process.env[m[1]] === undefined) process.env[m[1]] = value;
  }
}
loadEnvFile(path.join(STATE_DIR, ".env"));

const APP_TOKEN = process.env.SLACK_APP_TOKEN ?? ""; // xapp-…  (connections:write)
const BOT_TOKEN = process.env.SLACK_BOT_TOKEN ?? ""; // xoxb-…  (im:history, chat:write, im:write)
const SLACK_API_URL = process.env.SLACK_API_URL; // tests only; defaults to https://slack.com/api/

type Access = { allowFrom: string[]; relayTo: string[] };

// Slack user IDs look like U0123ABCD or W0123ABCD.
const USER_ID = /^[UW][A-Z0-9]{2,}$/;

function readAccess(): Access {
  try {
    const parsed = JSON.parse(readFileSync(ACCESS_FILE, "utf8"));
    const clean = (v: unknown) =>
      Array.isArray(v) ? v.filter((x): x is string => typeof x === "string" && USER_ID.test(x)) : [];
    const allowFrom = clean(parsed.allowFrom);
    // Only allowlisted users may approve tool calls.
    const relayTo = clean(parsed.relayTo).filter((u) => allowFrom.includes(u));
    return { allowFrom, relayTo };
  } catch {
    // Missing or unreadable file: allow nobody. Fail closed.
    return { allowFrom: [], relayTo: [] };
  }
}

function log(msg: string): void {
  // stdout is the MCP transport; all logging goes to stderr.
  process.stderr.write(`[slack-dm] ${msg}\n`);
}

if (!APP_TOKEN || !BOT_TOKEN) {
  log(`missing SLACK_APP_TOKEN or SLACK_BOT_TOKEN (looked in ${path.join(STATE_DIR, ".env")})`);
  process.exit(1);
}

// Permission relay is declared only when someone is set up to receive it.
const relayAtBoot = readAccess().relayTo.length > 0;

// ---------------------------------------------------------------- slack text helpers

// Slack escapes &, <, > in message text. Undo that on the way in...
function fromSlack(text: string): string {
  return text.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&amp;/g, "&");
}
// ...and escape them on the way out so Slack shows them literally.
function toSlack(text: string): string {
  return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

// ---------------------------------------------------------------- MCP server

const mcp = new Server(
  { name: "slack-dm", version: "1.0.0" },
  {
    capabilities: {
      experimental: {
        "claude/channel": {},
        ...(relayAtBoot ? { "claude/channel/permission": {} } : {}),
      },
      tools: {},
    },
    instructions:
      'Slack direct messages arrive as <channel source="slack-dm" chat_id="..." user="..." ts="...">. ' +
      "Only allowlisted Slack users can reach you. Answer with the reply tool, passing the chat_id " +
      "from the tag. Your terminal output is not visible to the sender; only the reply tool is.",
  },
);

const web = new WebClient(BOT_TOKEN, SLACK_API_URL ? { slackApiUrl: SLACK_API_URL } : {});

// DM channel IDs we have seen an allowlisted user write from. The reply tool
// only posts to these, so Claude cannot be talked into messaging anyone else.
const knownChats = new Map<string, string>(); // chat_id -> user id

mcp.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "reply",
      description: "Send a message back into the Slack DM the request came from",
      inputSchema: {
        type: "object",
        properties: {
          chat_id: { type: "string", description: "The chat_id from the <channel> tag" },
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
  const user = knownChats.get(chat_id);
  if (!user || !readAccess().allowFrom.includes(user)) {
    return {
      isError: true,
      content: [{ type: "text", text: `refused: ${chat_id || "(empty)"} is not a DM from an allowlisted user` }],
    };
  }
  if (!text.trim()) {
    return { isError: true, content: [{ type: "text", text: "refused: empty message" }] };
  }
  await web.chat.postMessage({ channel: chat_id, text: toSlack(text) });
  return { content: [{ type: "text", text: "sent" }] };
});

// Permission relay: Claude Code calls this when a tool-approval dialog opens.
const PermissionRequestSchema = z.object({
  method: z.literal("notifications/claude/channel/permission_request"),
  params: z.object({
    request_id: z.string(),
    tool_name: z.string(),
    description: z.string(),
    input_preview: z.string(),
  }),
});

mcp.setNotificationHandler(PermissionRequestSchema, async ({ params }) => {
  const { relayTo } = readAccess();
  const prompt =
    `Claude wants to run ${params.tool_name}: ${params.description}\n` +
    `${params.input_preview}\n\n` +
    `Reply "yes ${params.request_id}" or "no ${params.request_id}"`;
  for (const user of relayTo) {
    try {
      const opened = await web.conversations.open({ users: user });
      const channel = opened.channel?.id;
      if (channel) await web.chat.postMessage({ channel, text: toSlack(prompt) });
    } catch (err) {
      log(`could not relay permission prompt to ${user}: ${String(err)}`);
    }
  }
});

// ---------------------------------------------------------------- inbound

// "yes abcde" / "no abcde": the ID alphabet is a-z without "l".
const PERMISSION_REPLY_RE = /^\s*(y|yes|n|no)\s+([a-km-z]{5})\s*$/i;

type SlackMessageEvent = {
  type?: string;
  subtype?: string;
  channel?: string;
  channel_type?: string;
  user?: string;
  bot_id?: string;
  text?: string;
  ts?: string;
};

async function handleMessage(event: SlackMessageEvent): Promise<void> {
  // Direct messages only; ignore edits, joins, and anything a bot posted
  // (including our own replies).
  if (event.type !== "message" || event.channel_type !== "im") return;
  if (event.subtype || event.bot_id) return;
  if (!event.user || !event.channel || typeof event.text !== "string") return;

  // Gate on the sender, never on the channel.
  const access = readAccess();
  if (!access.allowFrom.includes(event.user)) {
    log(`dropped DM from non-allowlisted user ${event.user}`);
    return;
  }
  knownChats.set(event.channel, event.user);
  const text = fromSlack(event.text);

  const verdict = PERMISSION_REPLY_RE.exec(text);
  if (verdict && relayAtBoot && access.relayTo.includes(event.user)) {
    await mcp.notification({
      method: "notifications/claude/channel/permission",
      params: {
        request_id: verdict[2].toLowerCase(),
        behavior: verdict[1].toLowerCase().startsWith("y") ? "allow" : "deny",
      },
    });
    return;
  }

  await mcp.notification({
    method: "notifications/claude/channel",
    params: {
      content: text,
      meta: { chat_id: event.channel, user: event.user, ts: event.ts ?? "" },
    },
  });
}

// ---------------------------------------------------------------- start

await mcp.connect(new StdioServerTransport());

const socket = new SocketModeClient({
  appToken: APP_TOKEN,
  logLevel: LogLevel.WARN,
  ...(SLACK_API_URL ? { clientOptions: { slackApiUrl: SLACK_API_URL } } : {}),
});

socket.on("message", async ({ event, ack }: { event: SlackMessageEvent; ack: () => Promise<void> }) => {
  await ack(); // acknowledge within 3 seconds or Slack retries
  try {
    await handleMessage(event);
  } catch (err) {
    log(`error handling message: ${String(err)}`);
  }
});

await socket.start();
log(`connected; ${readAccess().allowFrom.length} allowlisted user(s); permission relay ${relayAtBoot ? "on" : "off"}`);
