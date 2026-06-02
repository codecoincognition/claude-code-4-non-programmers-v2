#!/usr/bin/env bash
#
# week-in-review.sh — "Make it yours" variation 4: Friday week-in-review.
#
# Friday at 5 PM, read all of this week's brief files in ~/work/briefs/, plus
# the week's Slack DMs, and write a 200-word reflection: what got done, what's
# still open, what surprised me, what I want to think about over the weekend.
# Save to ~/work/briefs/week-{YYYY-WW}.md.
#
# Pair with a SessionStart hook that shows it once on Sunday evening.
#
# Schedule by prompting Claude:
#   "Schedule week-in-review.sh to run every Friday at 5 PM."
# (cron `0 17 * * 5`.)
#
set -euo pipefail

BRIEFS_DIR="${HOME}/work/briefs"
WEEK_TAG="$(date '+%Y-%V')"   # YYYY-WW (ISO week)
OUT_FILE="${BRIEFS_DIR}/week-${WEEK_TAG}.md"

mkdir -p "${BRIEFS_DIR}"

read -r -d '' PROMPT <<EOF || true
Write a week-in-review reflection and save it to ${OUT_FILE}.

Read all of this week's brief files in ${BRIEFS_DIR}/ (the dated *.md files),
and pull my Slack DMs from the past week (slack MCP).

Write ~200 words covering:
  - What got done.
  - What's still open.
  - What surprised me.
  - What I want to think about over the weekend.

Keep the tone honest. If I missed something I said I'd do, name it. If a
thing I worried about turned out to be nothing, name that too. Don't make me
sound more productive than I was — flattering reflections get skipped on
Sunday; honest ones get re-read.

Write ONLY the file. Do not print to the terminal.
EOF

echo "Generating week-in-review -> ${OUT_FILE##*/}"
claude --print "${PROMPT}"
[[ -f "${OUT_FILE}" ]] && echo "Wrote ${OUT_FILE} ($(wc -c < "${OUT_FILE}" | tr -d ' ') bytes)"
