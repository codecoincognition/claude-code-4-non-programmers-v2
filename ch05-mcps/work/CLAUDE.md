# How to work in this folder

This is my work folder. When you start here, read this file first, then wait for me to tell you what I want.

## Who I am and what this folder is for

I run marketing operations. This folder holds my finance reconciliation, my inbox briefs, and the everyday work I hand to you. I am not a programmer. Explain what you are about to do in one plain sentence before you do it, then do it.

## House rules

- Always tell me what you're about to do in one line before you do it.
- Never send email, post to social, or delete anything without explicit confirmation. Drafting is fine; sending is not.
- When you write a file, tell me the full path and roughly how big it is.
- Money and dates matter. If a number or a date is ambiguous, ask instead of guessing.
- Cite your sources. When you pull a fact from an app (Gmail, Calendar, Notion), say which one.

## Folders

- `finance/` — bank exports, ledgers, reconciliation outputs.
- `inbox/` — cross-system briefs and synthesis files you write for me.

## My slash commands (in .claude/commands/)

- `/reconcile` — reconcile a bank export against my ledger.
- `/triage` — sort a folder of incoming files into the right places.
- `/renewals` — scan for upcoming subscription/contract renewals.

## My MCPs (connectors into the apps I use)

I have five MCP connectors installed (see `claude mcp list`). Use them when a task needs data that lives in one of these apps. Never send/post without my say-so.

- `gmail` — Read mail, draft replies. Does NOT send unless I explicitly say send.
- `calendar` — Read events, find free time, create events. No delete.
- `notion` — Read shared pages, search the workspace, append blocks. Only the pages I've shared with the "Claude Code" integration are visible.
- `slack` — Read channels/DMs, draft, send. (Parked — I'm not using it yet.)
- `buffer` — Schedule social posts. (Parked — I'm not using it yet.)

### Cross-system synthesis

When I ask you to "read X, Y, and Z and synthesize," pull from each MCP, cross-reference, write the result to the file path I name (usually under `inbox/`), and **cite each item by its source app**. If one source comes back empty, tell me which one before writing the file — don't silently drop it.

### When an MCP misbehaves

Use the recipe, in this order: (1) `claude mcp list` to confirm it's installed and which account it's authed as; (2) `claude mcp logs <name>` to read what the server is actually doing; (3) re-authenticate that MCP if the logs show an auth or wrong-account problem.
