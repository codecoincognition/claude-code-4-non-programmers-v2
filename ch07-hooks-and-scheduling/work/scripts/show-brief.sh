#!/usr/bin/env bash
#
# show-brief.sh
# -------------
# The command the SessionStart hook runs (Chapter 7, Steps 5–6).
#
# WHAT CHANGED AND WHY (Chapter 7 "When it goes wrong")
#   The first version of this script did a bare `cat` of today's brief on
#   line 4. If you opened your laptop BEFORE the 6:30 AM scheduled job had
#   run, today's file did not exist yet and the hook crashed with:
#       show-brief.sh: line 4: ~/work/briefs/2026-05-06.md: No such file ...
#   This version checks for today's brief first; if it is missing it falls
#   back to yesterday's brief with a one-line note explaining that today's
#   hasn't generated yet. The script never exits non-zero just because a
#   brief is absent — a missing brief must never block `claude` from starting.
#
set -uo pipefail

BRIEFS_DIR="${HOME}/work/briefs"
TODAY="$(date +%Y-%m-%d)"
YESTERDAY="$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d 'yesterday' +%Y-%m-%d)"

TODAY_FILE="${BRIEFS_DIR}/${TODAY}.md"
YDAY_FILE="${BRIEFS_DIR}/${YESTERDAY}.md"

if [[ -f "${TODAY_FILE}" ]]; then
  cat "${TODAY_FILE}"
elif [[ -f "${YDAY_FILE}" ]]; then
  echo "_(showing yesterday's brief — today's hasn't generated yet)_"
  echo
  cat "${YDAY_FILE}"
else
  echo "No brief yet today — and no brief from yesterday to fall back on."
fi

# Always succeed: a SessionStart hook that exits non-zero is noise the reader
# sees every morning. Quiet automation outlasts noisy automation.
exit 0
