# slack-dm — a custom Slack DM channel for Pheme

Make-it-yours #2 in Chapter 13. Lets the people you allowlist DM a Slack app,
and pushes each DM into your running Claude Code session as a
`<channel source="slack-dm">` event. Pheme answers with the `reply` tool and the
answer lands back in the same DM.

It follows Anthropic's channel contract
(<https://code.claude.com/docs/en/channels-reference>):

- declares the `claude/channel` capability and emits `notifications/claude/channel`
- exposes one tool, `reply` (`chat_id`, `text`)
- gates on the **sender's Slack user ID**, never on the channel
- optional permission relay to the users in `relayTo`
  (they answer `yes <id>` or `no <id>` in the DM)

It uses Slack **Socket Mode**: the server opens an outbound connection to Slack,
so you do not need a public URL or a tunnel.

## Files

| Path | What it is |
|---|---|
| `src/index.ts` | The channel server |
| `test/smoke.mjs` | End-to-end test against a fake Slack (no account needed) |
| `package.json`, `package-lock.json`, `tsconfig.json` | Build setup (Node 20+) |
| `.env.example` | The two tokens, to copy into `~/.claude/channels/slack-dm/.env` |
| `access.example.json` | The allowlist, to copy into `~/.claude/channels/slack-dm/access.json` |
| `mcp.json.example` | The entry to add to `~/work/.mcp.json` |

## Set it up

1. **Create the Slack app.** At <https://api.slack.com/apps>, choose
   *Create New App → From scratch*, name it Pheme, pick your workspace.
2. **Turn on Socket Mode** (*Settings → Socket Mode*). Create an app-level token
   with the `connections:write` scope. It starts with `xapp-`.
3. **Add bot scopes** (*OAuth & Permissions → Bot Token Scopes*): `im:history`,
   `chat:write`, `im:write`. Install the app to the workspace and copy the bot
   token. It starts with `xoxb-`.
4. **Subscribe to DMs** (*Event Subscriptions*): turn it on and add the bot event
   `message.im`. With Socket Mode on, Slack asks for no request URL.
5. **Let people DM the app** (*App Home → Show Tabs*): turn on the Messages tab
   and tick "Allow users to send Slash commands and messages from the messages tab".
6. **Find the user IDs to allow.** In Slack, open a person's profile, choose
   *⋯ → Copy member ID*. IDs look like `U0123ABCD`.
7. **Save the secrets and the allowlist**, readable only by you:

   ```bash
   mkdir -p ~/.claude/channels/slack-dm
   cp .env.example ~/.claude/channels/slack-dm/.env              # then fill in both tokens
   cp access.example.json ~/.claude/channels/slack-dm/access.json # then put in real user IDs
   chmod 600 ~/.claude/channels/slack-dm/.env
   ```

   `allowFrom` is who can reach Pheme. `relayTo` is who may approve tool calls
   from their phone; it must be a subset of `allowFrom`, and leaving it empty
   turns permission relay off. The server re-reads `access.json` on every
   message, so edits apply without a restart (except turning relay on or off,
   which needs a restart).
8. **Build it:**

   ```bash
   mkdir -p ~/work/mcp-servers
   cp -R . ~/work/mcp-servers/slack-dm && cd ~/work/mcp-servers/slack-dm
   npm install && npm run build
   ```

9. **Register it** in `~/work/.mcp.json` (see `mcp.json.example`; use the full
   path to `dist/index.js`).
10. **Launch with the development flag.** Custom channels are not on Anthropic's
    approved list during the research preview, so they load only with
    `--dangerously-load-development-channels`, in an interactive session, after
    a confirmation prompt:

    ```bash
    cd ~/work
    claude --channels plugin:telegram@claude-plugins-official plugin:imessage@claude-plugins-official \
           --dangerously-load-development-channels server:slack-dm
    ```

    To have Pheme listen on Slack too, add the same
    `--dangerously-load-development-channels server:slack-dm` to
    `~/work/scripts/pheme-listen.sh`, and add `mcp__slack-dm__reply` to the
    `tools:` list in `~/work/.claude/agents/pheme.md`. Without that tool in his
    list, Pheme can read Slack messages but cannot answer them.

## Check it

```bash
npm test
```

The test starts a fake Slack and checks, among other things: an allowlisted DM
becomes a channel event; a stranger's DM, a bot's message, an edit, and a public
channel message are all dropped; `reply` refuses any chat that is not a DM from
an allowlisted user; permission prompts go only to `relayTo` users; and only
`relayTo` users can approve.

## What it does not do

- No files or images: the text of each DM is forwarded; attachments are not.
- DMs only. Messages in channels and group conversations are ignored.
- Dropped messages are logged to the server's stderr. Run Claude Code with
  `--debug` to see them in `~/.claude/debug/`.
