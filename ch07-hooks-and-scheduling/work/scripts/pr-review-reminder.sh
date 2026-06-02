#!/usr/bin/env bash
#
# pr-review-reminder.sh — "Make it yours" variation 3: PR review reminder.
#
# The smallest useful hook in the chapter. At 9 AM weekdays, check GitHub for
# open pull requests waiting on YOUR review for more than 24 hours. Write a
# one-paragraph nudge to ~/work/briefs/prs-pending-{date}.md. If there are
# zero, say nothing — quiet automation outlasts noisy automation.
#
# Schedule by prompting Claude:
#   "Schedule pr-review-reminder.sh to run every weekday at 9 AM."
# (cron `0 9 * * 1-5`.)
#
# Requires the GitHub CLI (`gh`) authenticated, or a github MCP.
#
set -euo pipefail

BRIEFS_DIR="${HOME}/work/briefs"
TODAY="$(date +%Y-%m-%d)"
OUT_FILE="${BRIEFS_DIR}/prs-pending-${TODAY}.md"

mkdir -p "${BRIEFS_DIR}"

read -r -d '' PROMPT <<EOF || true
Check GitHub for open pull requests that have been waiting for MY review for
more than 24 hours. If there are any, write a one-paragraph nudge naming each
PR (repo, title, how long it has waited) and save it to ${OUT_FILE}.

If there are ZERO pending reviews, do not write a file and do not print
anything. Silence is the correct output when there is nothing to nudge.

Write ONLY the file (when there is something to write). Do not print to terminal.
EOF

claude --print "${PROMPT}"
[[ -f "${OUT_FILE}" ]] && echo "Wrote ${OUT_FILE}" || echo "No pending PR reviews — nothing written."
