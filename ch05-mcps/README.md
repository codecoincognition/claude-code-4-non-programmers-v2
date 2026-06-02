# Chapter 5 — Wire Claude into your stack: five MCPs and a cross-system prompt

This chapter installs five MCP connectors (Gmail, Calendar, Notion, Slack, Buffer) by prompting Claude in plain English — no config files edited by hand, no settings UI — and then proves the three core ones (Gmail, Calendar, Notion) work by running a single prompt that reads all three at once and writes a one-page priorities brief to a file you control. The "artifacts" of an MCP chapter are mostly *registry entries* and *auth tokens* (which live outside your repo, in `~/.claude.json` and your OS Keychain — never check those in). What this folder ships is the **output file** the synthesis prompt produces, the carried-forward `~/work` scaffolding the chapter is built on, and a `fixtures/` guide that explains the Gmail/Calendar/Notion inputs (which come from *your* accounts, so we don't fabricate private data — we describe the shape and give tiny synthetic samples).

## What's in this folder

| Path | Purpose |
|------|---------|
| `README.md` | This file. |
| `work/CLAUDE.md` | The project context Claude loads when you `cd ~/work && claude`. Carried forward from Ch 0.3–4 and extended with an MCP section. |
| `work/.claude/settings.local.json` | Permissions/settings carried forward into this chapter (still no hooks). |
| `work/.claude/commands/reconcile.md` | Slash command from Ch 4 (carried forward; still present). |
| `work/.claude/commands/triage.md` | Slash command from Ch 4 (carried forward). |
| `work/.claude/commands/renewals.md` | Slash command from Ch 4 (carried forward). |
| `work/inbox/2026-Q4-priorities.md` | **The chapter's payoff** — the full one-page cross-MCP synthesis brief, written verbatim from the Step 5 worked example. |
| `fixtures/README.md` | What the Gmail / Calendar / Notion inputs look like, plus tiny synthetic samples — so you can understand and (optionally) dry-run the synthesis without exposing real account data. |
| `fixtures/gmail-unread-sample.md` | Synthetic "5 unread threads" sample matching the chapter's example. |
| `fixtures/calendar-today-sample.md` | Synthetic "today's 4 events" sample. |
| `fixtures/notion-mentions-sample.md` | Synthetic "Notion mentions, last 24h" sample. |
| `mcp-debugging-recipe.md` | The list → logs → re-auth recipe and the four-question trust rubric, in one reference card. |

## How to use

1. Copy `work/` into your home directory so its contents merge with your real `~/work`:
   ```
   cp -R work/. ~/work/
   ```
   (This carries forward `CLAUDE.md`, the three slash commands, settings, and creates `~/work/inbox/`.)
2. Install the five MCPs by prompting Claude exactly as the chapter shows — one prompt each:
   - *"Add the Gmail MCP for me. I'll authenticate in the browser when you tell me to."*
   - *"Add the Google Calendar MCP the same way."*
   - *"Add the Notion MCP — I'll paste the integration token when you ask."*
   - *"Add the Slack MCP and the Buffer MCP."*
   Tokens land in your OS Keychain and the registry in `~/.claude.json` — **not** in this repo.
3. Run the synthesis prompt against your own accounts. The file it writes should look like `work/inbox/2026-Q4-priorities.md` (yours will have your real items).
4. If anything misbehaves, use `mcp-debugging-recipe.md`: list, logs, re-auth.

The book is self-contained — these files are ready-to-clone copies of what Chapter 5 walks you through building.
