# Chapter 13 — Pheme, your channels messenger

Pheme is the fifth specialist and the first one who runs *backwards*: instead of
waking on a schedule and pulling data, he waits for messages to be **pushed**
into a running Claude Code session. Telegram and iMessage arrive through
Anthropic's official channel plugins; Pheme reads Atlas's deploy status, Maya's
calendar, or Iris's queue, and answers through the same channel the question
came in on. Every channel has a sender allowlist, the night session runs in a
terminal tab Maya leaves open, and permission relay lets Maya approve a risky
action from her phone.

Channels are a research preview (Claude Code v2.1.80 or later; permission relay
v2.1.81 or later). Re-check <https://code.claude.com/docs/en/channels> before
relying on a behavior.

## Files in this folder

| Path | What it is |
|---|---|
| `work/.claude/agents/pheme.md` | Pheme's agent file: tool allowlist, reply rules, what he answers, what he never does, voice |
| `work/.claude/settings.json` | Carries forward the earlier settings and adds the PreToolUse hook that logs every channel reply |
| `work/scripts/pheme-listen.sh` | The launcher you run in the tab you leave open |
| `work/scripts/channel-events-log.sh` | The hook script: one line per reply in `~/work/.claude/audit/channel-events.log` |
| `fixtures/atlas/deploys/latest.md` | A synthetic deploy-status file, for rehearsing Pheme before Atlas has written a real one |
| `custom-channels/slack-dm/` | Make-it-yours #2: a working Slack DM channel (source, tests, setup guide) |
| `custom-channels/whatsapp/` | Make-it-yours #3: a working WhatsApp channel via Twilio, with quiet hours (source, tests, setup guide) |
| `prompts.md` | Every prompt from the chapter, verbatim and in order |

Not in this folder, on purpose: the Telegram bot token
(`~/.claude/channels/telegram/.env`), the allowlists
(`~/.claude/channels/telegram/access.json`,
`~/.claude/channels/imessage/access.json`), and the installed plugins. Those are
created on your machine by the `/plugin install`, `/telegram:configure`,
`/telegram:access`, and `/imessage:access` steps, and they hold secrets or
personal phone numbers.

## How to use

1. Follow Steps 1-4 in the chapter (or `prompts.md`) to install the two plugins,
   save the Telegram token, and set up both allowlists.
2. Copy `work/.claude/agents/pheme.md` to `~/work/.claude/agents/pheme.md`.
3. Copy `work/scripts/pheme-listen.sh` and `work/scripts/channel-events-log.sh`
   to `~/work/scripts/` and make them executable
   (`chmod +x ~/work/scripts/pheme-listen.sh ~/work/scripts/channel-events-log.sh`).
4. Merge the new PreToolUse entry from `work/.claude/settings.json` into your
   `~/work/.claude/settings.json`. The other entries are the ones you already
   have from earlier chapters.
5. Open a terminal tab you will leave alone and run
   `~/work/scripts/pheme-listen.sh`.
6. Text yourself on iMessage, or DM your bot on Telegram: *"deploy status?"*

## Where this folder differs from the printed chapter, and why

These are the only intentional differences. Each one fixes something that
would not work, or would not do what the chapter says, if copied exactly.

1. **Pheme's `tools:` list adds the two reply tools.** An agent with a `tools:`
   list can use only the tools in it. The printed list has no channel reply
   tool, so Pheme could read a message but never answer it. The repo version
   adds `mcp__plugin_telegram_telegram__reply` and
   `mcp__plugin_imessage_imessage__reply`, the names Claude Code gives the two
   plugins' reply tools. Everything else in the file is as printed. If you add
   Discord, Slack, or WhatsApp, add that channel's reply tool to the list too
   (`mcp__plugin_discord_discord__reply`, `mcp__slack-dm__reply`,
   `mcp__whatsapp__reply`).
2. **The launcher creates the session on the first run.** The printed script
   runs `claude --resume pheme`, which only works once a session named "pheme"
   already exists, so the very first run has nothing to resume. The repo version
   uses a fixed session ID: the first run starts the session with that ID and
   the name "pheme"; every later run resumes it.
3. **The audit log records Pheme's replies, not every inbound attempt.** Claude
   Code has no hook that fires when a channel message arrives, and messages from
   senders who are not on an allowlist are dropped by the channel before Claude
   Code sees them. So the PreToolUse hook logs each reply Pheme sends (time,
   channel, chat, first 80 characters). That is the record you sweep weekly.
   For the custom Slack and WhatsApp channels in this folder, dropped messages
   are also written to the server's own log (run Claude Code with `--debug` to
   capture it).
4. **iMessage group threads, in the current plugin.** The chapter's 3 AM story
   has a group thread trusted by accident and fixed by switching iMessage to
   "sender-only mode". In the current iMessage plugin, group threads never
   reach the session unless you opt each one in with
   `/imessage:access group add "<chat GUID>"`. If you do opt a group in, add
   `--allow` with the handles that may trigger Pheme, for example
   `/imessage:access group add "iMessage;+;chat123…" --allow +15550123`, so
   other members of the thread are ignored. One-to-one texts are already gated
   by sender.
5. **Make-it-yours #5** says the watchdog kill-switch is in Chapter 17. It is in
   Chapter 18 (the watchdog mesh).

## The custom channels (make-it-yours #2 and #3)

Both are complete, working servers, not skeletons. They follow Anthropic's
channel reference, gate on the sender, refuse to reply to anyone off the
allowlist, support permission relay for the people you name, and keep their
secrets in `~/.claude/channels/<name>/` like the official plugins. Each has an
`npm test` that runs the full message flow against a fake Slack or a fake
Twilio, so you can check it before connecting a real account. Setup guides are
in each folder's README.

During the research preview, custom channels load only with
`--dangerously-load-development-channels server:<name>`, in an interactive
session, after a confirmation prompt.
