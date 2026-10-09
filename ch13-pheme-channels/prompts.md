# Chapter 13 — Pheme, your channels messenger: prompts, verbatim and in order

Every prompt the chapter has you run, copy-paste ready.

## Conducting Pheme's first night

### Step 1 — Install Anthropic's Telegram and iMessage plugins

```
Install Anthropic's official Telegram and iMessage channel plugins. After they install, reload the plugins so I can use their configure commands.
```

### Step 2 — Make a Telegram bot and save its token

(First make the bot in Telegram: message @BotFather, send /newbot, pick a display name and a username ending in "bot". Then:)

```
I got my Telegram bot token from BotFather. Save it to the place the Telegram channel plugin expects, and confirm where it lands so I know what file holds the secret.
```

### Step 3 — Restart Claude Code with both channels enabled

```
Restart Claude Code with both channel plugins enabled — Telegram and iMessage. Then run /channels and show me which channels are registered.

Show me the boot banner so I can confirm both channels are registered.
```

### Step 4 — Pair Telegram, allow Dana on iMessage

```
I just DMed the bot and got a pairing code: kndhx. Pair me, then lock the policy to allowlist so only people I explicitly add can send messages.
```

```
Dana wants to text me work questions through the Telegram bot. She'll DM the bot to get her own pairing code. When she sends me the code, I'll pair her too.
```

```
Add Dana's phone number to the iMessage allowlist: +1-555-0123. Then show me what the allowlist looks like now on both channels so I can sanity-check.
```

### Step 5 — Author Pheme

```
Hire a staff member named Pheme. His job is to listen on Telegram and iMessage and answer the questions Dana and my family send late at night, without waking me up.

He reads my Atlas status files at ~/work/atlas/ when someone asks about a deploy. He reads my Notion calendar when someone asks what I have on. He reads ~/work/queue/{date}.md when someone asks what's in the queue today.

He NEVER sends mail. He NEVER writes to the CRM. He NEVER touches my financial CSVs. He replies through the same channel the question came in on (Telegram in to Telegram out, iMessage in to iMessage out).

Voice: short, plain English, no greeting, no signoff, no apologies, no exclamation points. Always names the source he answered from so I can audit ("from atlas/deploys/latest.md").

Write the file at ~/work/.claude/agents/pheme.md.
```

### Step 6 — Run Pheme's session in the background

```
Set me up a background Claude Code session named "pheme" that runs Pheme as the active agent with both channels enabled. Same launch as Step 3, and name the session "pheme" so if I close the tab and reopen it I land back in the same session. Write a small launcher script at ~/work/scripts/pheme-listen.sh I can run when I open a new terminal tab.
```

### Step 7 — Permission relay when Pheme needs approval

```
Turn on permission relay for the Telegram channel. When Pheme tries to do something that needs my approval — clearing a queue, calling a webhook, anything that would normally pop a tool-approval dialog — forward the approval prompt to me on Telegram so I can answer from my phone instead of walking downstairs.
```

## When it goes wrong — the 3 AM prompt injection

```
Audit my channel allowlists. Show me every sender currently allowed on Telegram and iMessage and the policy on each. Then recommend the tightest possible policy I can set without breaking Dana's late-night usage or my own self-chat. After I confirm, also add a PreToolUse hook that logs every channel event to ~/work/.claude/audit/channel-events.log with sender, channel, timestamp, and the first 80 characters of the message — so I can sweep this file weekly for weird traffic.
```

## The prompt grammar (from the lift)

```
Hire a staff member named {name}. He listens on {channel A} and {channel B}. When {trusted sender} sends a {kind of question}, he reads {source-of-truth file or system} and replies in plain English through the same channel. He never {irreversible action}. Sender allowlist on every channel. Run him in the background.
```

## Make it yours

### 1. Add Discord as the third official channel

```
Install discord@claude-plugins-official, walk me through making the Discord bot (the OAuth permissions Pheme needs are View Channels, Send Messages, Read Message History, and Add Reactions), configure my token, and update my pheme-listen.sh launcher to include plugin:discord@claude-plugins-official in the --channels list. Lock Discord's policy to allowlist the same way we did Telegram.
```

### 2. Slack DM channel — via Chapter 14's custom-MCP pattern

```
After I finish Chapter 14, I want a Slack-DM channel so my team can DM Pheme from our work Slack. The skeleton is in the companion repo at ch13-pheme-channels/custom-channels/slack-dm/. Walk me through installing it, registering it in .mcp.json, and launching with --dangerously-load-development-channels (since it is not on Anthropic's official allowlist). Use a Slack sender allowlist by user ID, not channel ID.
```

### 3. WhatsApp channel — Twilio-backed, same shape

```
Build a WhatsApp channel using Twilio as the inbound webhook receiver. Pattern matches Slack DM: incoming-message handler in a small MCP server, sender allowlist on phone numbers in +country format, no replies between 10 PM and 7 AM unless the message contains URGENT. Skeleton at ch13-pheme-channels/custom-channels/whatsapp/.
```

### 4. Quiet hours

```
Update Pheme's agent file so he does not relay or reply to any channel message between 10 PM and 7 AM local time, with one exception: if the message contains the exact word URGENT he answers immediately. Otherwise the message is queued silently and surfaced in tomorrow morning's brief alongside Iris's queue.
```

### 5. Escalation pattern — Telegram URGENT triggers Chapter 17's kill-switch

```
If a Telegram message contains the exact word URGENT and Atlas's latest.md shows any monitor in red or any error in the last 5 minutes, have Pheme post the kill-switch status to the channel and ask me through permission relay whether to invoke the watchdog kill-switch from Chapter 17. He posts the result back to the channel either way.
```

(The published prompt says "Chapter 17"; the watchdog mesh and its kill-switch are in Chapter 18.)

## Test yourself in 60 seconds

```
Show me which channels are active in this session and which senders are on each allowlist.
```

```
Open ~/work/.claude/agents/pheme.md and explain in one sentence what each section does.
```

```
Tell me why pairing a Telegram sender is different from allowing an iMessage handle, in one sentence each.
```

Stuck?

```
audit my Chapter 13 setup against the chapter spec
```
