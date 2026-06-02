#!/usr/bin/env bash
#
# eod-brief.sh — "Make it yours" variation 1: Evening shutdown brief.
#
# Every weekday at 6 PM, read the last 8 hours of Slack DMs, the Gmail outbox,
# and Notion edits, and write a one-paragraph end-of-day note titled
# "What I touched today and what I owe people tomorrow."
# Save to ~/work/briefs/eod-{date}.md.
#
# Schedule it by prompting Claude:
#   "Schedule eod-brief.sh to run every weekday at 6 PM."
# (Claude converts that to cron `0 18 * * 1-5`.)
#
set -euo pipefail

BRIEFS_DIR="${HOME}/work/briefs"
TODAY="$(date +%Y-%m-%d)"
PRETTY_DATE="$(date '+%a %b %-d %Y')"
OUT_FILE="${BRIEFS_DIR}/eod-${TODAY}.md"

mkdir -p "${BRIEFS_DIR}"

read -r -d '' PROMPT <<EOF || true
Write an end-of-day note and save it to ${OUT_FILE} (overwrite if it exists).

Gather, using my connected MCPs only:
  1. My last 8 hours of Slack DMs (slack MCP) — who I owe a reply.
  2. My Gmail outbox / sent in the last 8 hours (gmail MCP).
  3. Notion pages I edited today (notion MCP).

Write the file in this shape:

---
# End of day — ${PRETTY_DATE}

## What I touched today and what I owe people tomorrow

<One honest paragraph. Name people I left hanging. Name what I shipped.
Name what slid. Don't make me sound more productive than I was.>
---

Write ONLY the file. Do not print to the terminal.
EOF

echo "Generating end-of-day note -> ${OUT_FILE##*/}"
claude --print "${PROMPT}"
[[ -f "${OUT_FILE}" ]] && echo "Wrote ${OUT_FILE} ($(wc -c < "${OUT_FILE}" | tr -d ' ') bytes)"
