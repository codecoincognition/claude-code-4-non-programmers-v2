#!/usr/bin/env bash
#
# morning-brief.sh
# ----------------
# Reference implementation of the morning-brief generator from Chapter 7.
#
# WHAT IT DOES
#   Reads three sources — unread Gmail (last 12h), today's calendar events,
#   and Notion mentions/assigned tasks — and writes a one-page brief to
#   ~/work/briefs/{YYYY-MM-DD}.md with a short synthesis at the top:
#   "Three things that matter today, in priority order, one sentence each."
#
# HOW THE TWO LAYERS WORK (Chapter 7 "The lift")
#   This shell script is the DETERMINISTIC layer. Its only job is to gather
#   the raw material from your MCPs and hand it to Claude, which is the
#   INTELLIGENT layer that synthesizes and prioritizes. In the book you do
#   not write this by hand — you prompt Claude and Claude writes it, then
#   saves it here. This file is a faithful, runnable copy of what Claude
#   produces so you can clone instead of build.
#
# IDEMPOTENT
#   Running this twice on the same day overwrites today's brief rather than
#   appending. You will never get a double brief.
#
# SAFETY (Chapter 7 "Read what Claude writes before you save it")
#   - Every file path stays inside ~/work.
#   - The only network calls are through your connected MCPs (gmail, calendar,
#     notion) invoked via `claude -p` headless prompts. No raw curl to servers
#     you don't recognize.
#
# REQUIREMENTS
#   - Claude Code installed and on your PATH (`claude`).
#   - Gmail, Calendar, and Notion connected as MCPs (Chapter 5).
#
set -euo pipefail

# --- Paths (all inside ~/work) ------------------------------------------------
WORK_DIR="${HOME}/work"
BRIEFS_DIR="${WORK_DIR}/briefs"
TODAY="$(date +%Y-%m-%d)"
PRETTY_DATE="$(date '+%a %b %-d %Y')"
OUT_FILE="${BRIEFS_DIR}/${TODAY}.md"

mkdir -p "${BRIEFS_DIR}"

# --- The prompt handed to Claude ----------------------------------------------
# Claude does the reading (via MCPs) and the synthesis in one headless pass.
# We ask it to write the file itself so the deterministic shell never has to
# parse Gmail/Calendar/Notion payloads.
read -r -d '' BRIEF_PROMPT <<EOF || true
Write today's morning brief and save it to ${OUT_FILE} (overwrite if it exists).

Gather, using my connected MCPs only:
  1. Unread Gmail from the last 12 hours (gmail MCP) — sender + one-line gist each.
  2. Today's calendar events (calendar MCP) — time + title + attendees.
  3. Notion mentions of me and tasks assigned to me (notion MCP).

Then write the file in this exact shape:

---
# Brief — ${PRETTY_DATE}

**Three things that matter today:**
1. <highest-priority thing, one sentence, name the person/deadline>
2. <second thing, one sentence>
3. <third thing, one sentence>

## Inbox (unread, last 12h)
- <sender> — <one-line gist>

## Today's calendar
- <time> <title> (<attendees>)

## Notion
- <mention or assigned task>
---

Keep the synthesis honest and short. Prioritize by deadline and by who is
blocked on me. Do not invent items — if a source is empty, write "nothing".
Write ONLY the file. Do not print the brief to the terminal.
EOF

echo "Running ${OUT_FILE##*/} generation..."
echo "Reading Gmail (last 12h, unread), Calendar (today), Notion (mentions + assigned) via MCPs..."

# Headless, single-shot. --print runs the prompt and exits.
claude --print "${BRIEF_PROMPT}"

# --- Report -------------------------------------------------------------------
if [[ -f "${OUT_FILE}" ]]; then
  BYTES="$(wc -c < "${OUT_FILE}" | tr -d ' ')"
  echo "Wrote ${OUT_FILE} (${BYTES} bytes)"
else
  echo "ERROR: brief was not written to ${OUT_FILE}" >&2
  exit 1
fi
