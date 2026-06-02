#!/usr/bin/env bash
#
# stock-watcher.sh — "Make it yours" variation 5: Stock-watcher hook.
#
# Daily at 4:30 PM Eastern, fetch closing prices for the tickers in
# ~/work/watchlist.txt, compare to last week's close, and write a one-line
# note about anything that moved more than 3%. Add it to the next morning's
# SessionStart hook output.
#
# Schedule by prompting Claude:
#   "Schedule stock-watcher.sh to run every weekday at 4:30 PM Eastern."
# (cron `30 16 * * 1-5` in US/Eastern.)
#
set -euo pipefail

WORK_DIR="${HOME}/work"
BRIEFS_DIR="${WORK_DIR}/briefs"
WATCHLIST="${WORK_DIR}/watchlist.txt"
TODAY="$(date +%Y-%m-%d)"
OUT_FILE="${BRIEFS_DIR}/stocks-${TODAY}.md"

mkdir -p "${BRIEFS_DIR}"

if [[ ! -f "${WATCHLIST}" ]]; then
  echo "No watchlist at ${WATCHLIST} — create one ticker per line." >&2
  exit 0
fi

read -r -d '' PROMPT <<EOF || true
Read the tickers in ${WATCHLIST} (one per line). For each, fetch today's
closing price and compare it to last week's close. Write a one-line note for
ANY ticker that moved more than 3% (up or down) and save the notes to
${OUT_FILE} under a "# Movers — ${TODAY}" heading.

If nothing moved more than 3%, write a single line: "No movers > 3% today."

Write ONLY the file. Do not print to the terminal.
EOF

claude --print "${PROMPT}"
[[ -f "${OUT_FILE}" ]] && echo "Wrote ${OUT_FILE}"
