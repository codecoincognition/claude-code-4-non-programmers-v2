# Errata & Updates

*Companion to **Claude Code for Non-Programmers (2nd Edition)** by Vikas Sah.*

This page tracks corrections and updates to the book after publication. Claude Code evolves quickly; where a command, flag, or menu has changed since the book went to print, the current form is noted here.

## How to read this page

Entries are grouped by chapter and dated. The book is self-contained — nothing here is required to complete a chapter — but if a step behaves differently than the book describes, check here first.

## Corrections

### Chapter 4 — Three verbs you'll run every day

- *2026-10-08.* The power-user commands are met in Part VII, which is **Chapters 23-25**, not "Ch 24-25".

### Chapter 12 — Echo, the CRM hygienist

- *2026-10-08.* The chapter ends "ready for Chapter 14" and "→ Chapter 14 hires Pheme". Pheme is hired in **Chapter 13**.

### Chapter 13 — Pheme, your channels messenger

- *2026-10-08.* **Pheme's agent file needs the channel reply tools.** An agent with a `tools:` list can use only the tools in it, and the printed list has no reply tool, so Pheme can read a message but cannot answer it. Add these two lines to the `tools:` list in `~/work/.claude/agents/pheme.md`:

  ```yaml
    - mcp__plugin_telegram_telegram__reply
    - mcp__plugin_imessage_imessage__reply
  ```

  If you add Discord, also add `mcp__plugin_discord_discord__reply`.
- *2026-10-08.* **The launcher's first run.** `claude --resume pheme` works only once a session named "pheme" exists, so the very first run of the printed `pheme-listen.sh` has nothing to resume. Start the first session with `claude --name pheme --agent pheme --channels …`, or use the launcher in [`ch13-pheme-channels/work/scripts/`](./ch13-pheme-channels/work/scripts/pheme-listen.sh), which handles both cases.
- *2026-10-08.* **What the channel-events log can record.** Claude Code has no hook that fires when a channel message arrives, and messages from senders who are not allowlisted are dropped by the channel before Claude Code sees them. A PreToolUse hook therefore logs the replies Pheme sends, not every inbound attempt. The repo's hook does exactly that.
- *2026-10-08.* **iMessage group threads.** In the current iMessage plugin, group threads reach the session only if you opt each one in with `/imessage:access group add "<chat GUID>"`. If you do, add `--allow` with the handles that may trigger Pheme, so other members of the thread are ignored. This is the real form of the "sender-only mode" in the chapter's 3 AM story.
- *2026-10-08.* Make-it-yours #5 and the paragraph after it refer to "Chapter 17's kill-switch". The watchdog mesh and its kill-switch are in **Chapter 18**.

### Chapter 18 — The watchdog mesh

- *2026-10-08.* **The kill-switch must ask in a dialog, not at a prompt.** A hook has no terminal, and its input is the JSON payload, so the printed script's `read` returns at once and every escalation is denied without anyone being asked. The scripts in [`ch18-watchdog-mesh/work/scripts/`](./ch18-watchdog-mesh/work/scripts/) ask for the code in a dialog instead (macOS, Linux, Windows).
- *2026-10-08.* The script comment "anything non-zero would block" is not right: **only exit code 2 blocks** a tool call. A crash, any other exit code, or a hook that runs past its timeout lets the call through, so a gate must exit 2 on every failure path.

### Chapter 20 — The landing page that converts

- *2026-10-08.* The PostHog snippet printed at the top of `script.js` is a shortened placeholder, not runnable code; paste the full official snippet from your PostHog project. The repo's `script.js` keeps the page (A/B test and form) working until you do.

### Appendix I — Power-user command reference

- *2026-10-08.* The commands in this reference are introduced in **Chapters 23-25** (and the channel commands in Chapter 13), not "chapters 22-24".

## Reporting an issue

Found something that doesn't match? Open an issue on this repository with the chapter number, the step, and what you saw.

---

*Last updated: 2026-10-08.*
