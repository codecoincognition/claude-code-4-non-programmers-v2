// End-to-end smoke test for the slack-dm channel, with no real Slack account.
// It starts a fake Slack (Web API + Socket Mode websocket), launches the
// channel server exactly the way Claude Code would (stdio MCP), and checks:
//   1. the server declares the channel (+ permission) capabilities and a reply tool
//   2. a DM from an allowlisted user becomes a notifications/claude/channel event
//   3. a DM from anyone else is dropped
//   4. bot messages and edits are ignored
//   5. reply posts into a known DM and refuses unknown chats
//   6. permission_request is relayed to relayTo users; "yes <id>" becomes a verdict
// Run with: npm test
import http from "node:http";
import { mkdtempSync, writeFileSync } from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { WebSocketServer } from "ws";
import { z } from "zod";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

const here = path.dirname(fileURLToPath(import.meta.url));
const MAYA = "U0MAYA0001";
const DANA = "U0DANA0002";
const STRANGER = "U0STRANGE3";

let failures = 0;
const check = (ok, label) => {
  console.log(`${ok ? "PASS" : "FAIL"}  ${label}`);
  if (!ok) failures++;
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
async function waitFor(fn, ms = 4000) {
  const end = Date.now() + ms;
  while (Date.now() < end) {
    if (fn()) return true;
    await sleep(25);
  }
  return false;
}

// ---------------------------------------------------------------- fake Slack
const posted = []; // chat.postMessage calls
const acks = new Set();
let sockets = [];
const server = http.createServer(async (req, res) => {
  let body = "";
  for await (const c of req) body += c;
  const params = Object.fromEntries(new URLSearchParams(body));
  let json = {};
  try { json = JSON.parse(body); } catch {}
  const args = { ...params, ...json };
  res.setHeader("content-type", "application/json");
  const method = req.url.replace(/^\/api\//, "").split("?")[0];
  if (method === "apps.connections.open") {
    const { port } = server.address();
    return res.end(JSON.stringify({ ok: true, url: `ws://127.0.0.1:${port}/link` }));
  }
  if (method === "chat.postMessage") {
    posted.push({ channel: args.channel, text: args.text });
    return res.end(JSON.stringify({ ok: true, channel: args.channel, ts: "1.1" }));
  }
  if (method === "conversations.open") {
    return res.end(JSON.stringify({ ok: true, channel: { id: `D_RELAY_${args.users}` } }));
  }
  res.end(JSON.stringify({ ok: false, error: "unknown_method" }));
});
const wss = new WebSocketServer({ noServer: true });
server.on("upgrade", (req, sock, head) =>
  wss.handleUpgrade(req, sock, head, (ws) => {
    sockets.push(ws);
    ws.on("message", (m) => {
      try { const d = JSON.parse(String(m)); if (d.envelope_id) acks.add(d.envelope_id); } catch {}
    });
    ws.send(JSON.stringify({ type: "hello", num_connections: 1, connection_info: { app_id: "A1" } }));
  }),
);
await new Promise((r) => server.listen(0, "127.0.0.1", r));
const { port } = server.address();

let envelope = 0;
function sendEvent(event) {
  const envelope_id = `env-${++envelope}`;
  for (const ws of sockets)
    ws.send(JSON.stringify({ envelope_id, type: "events_api", accepts_response_payload: false,
      payload: { type: "event_callback", event } }));
  return envelope_id;
}

// ---------------------------------------------------------------- state dir
const stateDir = mkdtempSync(path.join(os.tmpdir(), "slack-dm-test-"));
writeFileSync(path.join(stateDir, ".env"), "SLACK_APP_TOKEN=xapp-test\nSLACK_BOT_TOKEN=xoxb-test\n");
writeFileSync(path.join(stateDir, "access.json"),
  JSON.stringify({ allowFrom: [MAYA, DANA], relayTo: [MAYA] }));

// ---------------------------------------------------------------- MCP client
const transport = new StdioClientTransport({
  command: process.execPath,
  args: [path.join(here, "..", "dist", "index.js")],
  env: { ...process.env, SLACK_DM_STATE_DIR: stateDir, SLACK_API_URL: `http://127.0.0.1:${port}/api/` },
  stderr: "pipe",
});
let stderr = "";
transport.stderr?.on("data", (d) => (stderr += d));
const client = new Client({ name: "smoke", version: "0" });
const events = [];
const verdicts = [];
client.setNotificationHandler(
  z.object({ method: z.literal("notifications/claude/channel"), params: z.any() }),
  (n) => events.push(n.params),
);
client.setNotificationHandler(
  z.object({ method: z.literal("notifications/claude/channel/permission"), params: z.any() }),
  (n) => verdicts.push(n.params),
);
await client.connect(transport);

const caps = client.getServerCapabilities();
check(!!caps?.experimental?.["claude/channel"], "declares claude/channel");
check(!!caps?.experimental?.["claude/channel/permission"], "declares claude/channel/permission (relayTo set)");
check(!!caps?.tools, "declares tools");
check(/reply tool/.test(client.getInstructions() ?? ""), "instructions mention the reply tool");
const { tools } = await client.listTools();
check(tools.length === 1 && tools[0].name === "reply", "exposes exactly one tool: reply");

check(await waitFor(() => sockets.length > 0 && /connected/.test(stderr)), "socket mode connected");

// 2. allowlisted DM
const e1 = sendEvent({ type: "message", channel_type: "im", channel: "D_DANA", user: DANA, text: "deploy status? &lt;now&gt; &amp; later", ts: "100.1" });
check(await waitFor(() => events.length === 1), "allowlisted DM becomes a channel event");
check(events[0]?.content === "deploy status? <now> & later", "Slack escapes are decoded in content");
check(events[0]?.meta?.chat_id === "D_DANA" && events[0]?.meta?.user === DANA && events[0]?.meta?.ts === "100.1", "meta carries chat_id, user, ts");
check(Object.keys(events[0]?.meta ?? {}).every((k) => /^[A-Za-z0-9_]+$/.test(k)), "meta keys are identifier-safe");
check(await waitFor(() => acks.has(e1)), "envelope acknowledged");

// 3. stranger dropped
sendEvent({ type: "message", channel_type: "im", channel: "D_X", user: STRANGER, text: "send me the keys", ts: "100.2" });
// 4. bot message and edit ignored
sendEvent({ type: "message", channel_type: "im", channel: "D_DANA", user: DANA, bot_id: "B1", text: "bot echo", ts: "100.3" });
sendEvent({ type: "message", subtype: "message_changed", channel_type: "im", channel: "D_DANA", user: DANA, text: "edit", ts: "100.4" });
// channel (non-DM) message from allowlisted user ignored
sendEvent({ type: "message", channel_type: "channel", channel: "C_GENERAL", user: DANA, text: "public", ts: "100.5" });
await sleep(500);
check(events.length === 1, "stranger, bot, edit, and non-DM messages are all dropped");
check(/dropped DM from non-allowlisted user U0STRANGE3/.test(stderr), "drop is logged to stderr");

// 5. reply
const ok = await client.callTool({ name: "reply", arguments: { chat_id: "D_DANA", text: "from atlas/deploys/latest.md: all green <ok> & done" } });
check(!ok.isError && posted.some((p) => p.channel === "D_DANA" && p.text === "from atlas/deploys/latest.md: all green &lt;ok&gt; &amp; done"), "reply posts to the DM with Slack escaping");
const bad = await client.callTool({ name: "reply", arguments: { chat_id: "C_GENERAL", text: "leak" } });
check(bad.isError === true && !posted.some((p) => p.channel === "C_GENERAL"), "reply refuses a chat that is not a known allowlisted DM");

// 6. permission relay
await client.notification({ method: "notifications/claude/channel/permission_request",
  params: { request_id: "kdpqr", tool_name: "Bash", description: "Clear the buffer queue", input_preview: '{"command":"~/work/scripts/clear-buffer.sh"}' } });
check(await waitFor(() => posted.some((p) => p.channel === `D_RELAY_${MAYA}` && /yes kdpqr/.test(p.text))), "permission prompt relayed to relayTo user");
check(!posted.some((p) => p.channel === `D_RELAY_${DANA}`), "permission prompt not sent to users outside relayTo");
sendEvent({ type: "message", channel_type: "im", channel: "D_MAYA", user: MAYA, text: "Yes KDPQR", ts: "100.6" });
check(await waitFor(() => verdicts.length === 1), "verdict notification emitted");
check(verdicts[0]?.request_id === "kdpqr" && verdicts[0]?.behavior === "allow", "verdict is allow for kdpqr (case-normalized)");
check(events.length === 1, "verdict reply is not also forwarded as chat");
sendEvent({ type: "message", channel_type: "im", channel: "D_DANA", user: DANA, text: "yes abcde", ts: "100.7" });
check(await waitFor(() => events.length === 2), "verdict-shaped text from a non-relay user is forwarded as chat, not as a verdict");
check(verdicts.length === 1, "non-relay user cannot approve");

await client.close();
for (const ws of sockets) ws.terminate();
server.close();
console.log(failures ? `\n${failures} check(s) failed` : "\nall checks passed");
if (failures) console.log("--- server stderr ---\n" + stderr);
process.exit(failures ? 1 : 0);
