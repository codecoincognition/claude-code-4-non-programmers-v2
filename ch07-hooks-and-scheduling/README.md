# Chapter 7 — Hooks and scheduling

This chapter builds two primitives that make Claude work when you're not at the
keyboard: a **scheduled job** (time-triggered) that writes a one-page morning
brief at 6:30 AM every weekday, and a **`SessionStart` hook** (event-triggered)
that shows today's brief the moment you type `claude`. A small deterministic
shell script gathers the raw material from your MCPs; Claude does the
synthesis. These files are the chapter's reference implementation plus the five
"Make it yours" variations.

## File-by-file

| Path | What it is |
|---|---|
| `work/scripts/morning-brief.sh` | The ~60-line generator (Step 2). Reads unread Gmail, today's calendar, and Notion mentions via your MCPs and writes `~/work/briefs/{date}.md`. Idempotent. |
| `work/scripts/show-brief.sh` | The ~12-line command the hook runs (Steps 5–6). Prints today's brief; falls back to yesterday's with a note if today's hasn't generated yet (the "When it goes wrong" fix). Never exits non-zero. |
| `work/.claude/settings.json` | The `SessionStart` hook block that calls `show-brief.sh` at the start of every session in `~/work`. |
| `prompts.md` | Every plain-English prompt the chapter uses, in order — the prompts that produce all the files below. |
| `work/scripts/eod-brief.sh` | "Make it yours" #1 — evening shutdown brief (cron `0 18 * * 1-5`). |
| `work/scripts/pre-meeting-brief.sh` | "Make it yours" #2 — calendar-poll pre-meeting brief, every 15 min weekdays (cron `*/15 * * * 1-5`). |
| `work/scripts/pr-review-reminder.sh` | "Make it yours" #3 — 9 AM PR-review nudge that stays silent when there's nothing pending (cron `0 9 * * 1-5`). |
| `work/scripts/week-in-review.sh` | "Make it yours" #4 — Friday 5 PM week-in-review reflection (cron `0 17 * * 5`). |
| `work/scripts/stock-watcher.sh` | "Make it yours" #5 — 4:30 PM ET movers note from `watchlist.txt` (cron `30 16 * * 1-5`). |
| `work/watchlist.txt` | Sample ticker list read by `stock-watcher.sh`. |
| `work/briefs/2026-05-05.md` | Sample generated brief so the hook has something to show on a fresh clone. |
| `fixtures/README.md` | What the MCP-fed inputs look like, and why we don't ship fake mailboxes. |

## How to use

1. Copy the contents of `work/` into your own `~/work/`:
   ```bash
   cp -R work/scripts   ~/work/
   cp -R work/.claude    ~/work/
   cp    work/watchlist.txt ~/work/
   chmod +x ~/work/scripts/*.sh
   ```
2. Make sure Gmail, Calendar, and Notion are connected as MCPs (Chapter 5).
3. Run the generator once by hand to see what it produces:
   ```bash
   ~/work/scripts/morning-brief.sh
   ```
4. Schedule it by prompting Claude: *"Schedule morning-brief.sh to run every
   weekday at 6:30 AM."* (Claude turns that into cron `30 6 * * 1-5`.)
5. The `SessionStart` hook in `work/.claude/settings.json` is already wired to
   `show-brief.sh` — start a fresh `claude` session in `~/work` to see it fire.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 7 walks you through building.
