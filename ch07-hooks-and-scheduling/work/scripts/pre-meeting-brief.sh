#!/usr/bin/env bash
#
# pre-meeting-brief.sh — "Make it yours" variation 2: Pre-meeting brief.
#
# Runs every 15 minutes during weekdays. If a meeting is starting in the next
# 20 minutes, generate a brief about it: who's attending, the agenda from the
# calendar invite, the last three Slack threads with each attendee, and any
# Notion docs they've recently edited. Surface it via a Stop hook on whatever
# you're currently doing (the chapter shows it through a brief file too).
#
# Schedule by prompting Claude:
#   "Schedule pre-meeting-brief.sh to run every 15 minutes on weekdays."
# (cron `*/15 * * * 1-5`.)
#
# Quiet automation: if there is no meeting in the next 20 minutes, this writes
# nothing and prints nothing. Silence is the correct output most of the day.
#
set -euo pipefail

BRIEFS_DIR="${HOME}/work/briefs"
TODAY="$(date +%Y-%m-%d)"
STAMP="$(date +%H%M)"
OUT_FILE="${BRIEFS_DIR}/meeting-${TODAY}-${STAMP}.md"

mkdir -p "${BRIEFS_DIR}"

read -r -d '' PROMPT <<EOF || true
Check my calendar (calendar MCP) for any event STARTING in the next 20 minutes.

If there is NO such meeting, do not write a file and do not print anything.
Silence is correct when there is nothing imminent.

If there IS a meeting starting soon, build a pre-meeting brief and save it to
${OUT_FILE}, using my connected MCPs only:
  1. The meeting itself (calendar MCP) — time, title, attendees, and the
     agenda/description from the invite.
  2. For each attendee: my last three Slack threads with them (slack MCP).
  3. Any Notion docs those attendees have recently edited (notion MCP).

Write the file in this shape:

---
# Pre-meeting brief — <title> @ <time>

**Attendees:** <names>

## Agenda (from the invite)
<agenda, or "no agenda in the invite">

## Recent context per attendee
- <name> — last threads: <one-line gist each>; recent Notion: <doc titles>
---

Keep it short — this is a glance before you walk in, not a dossier.
Write ONLY the file. Do not print to the terminal.
EOF

claude --print "${PROMPT}"
[[ -f "${OUT_FILE}" ]] && echo "Wrote ${OUT_FILE}" || true
