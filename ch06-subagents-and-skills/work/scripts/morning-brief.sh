#!/usr/bin/env bash
#
# morning-brief.sh — writes a daily brief of overnight Gmail to a dated
# markdown file. Used by Chapter 6 as the target the debugging skill
# practices on, and by Chapter 7 as the real morning brief.
#
# Earlier draft had a timezone bug; this is the fixed version per Ch 6
# when-it-goes-wrong beat. The buggy draft computed the Gmail query
# window in UTC, which on the Tue->Wed local-time boundary lands inside
# the wrong UTC calendar day and matches 0 messages — so the brief came
# out empty on Wednesdays only. The fix is to pass an explicit local
# timezone (America/New_York here) so the window is local, not UTC.

set -euo pipefail

TODAY="$(date +%Y-%m-%d)"
OUTDIR="$HOME/work/briefs"
OUTFILE="$OUTDIR/brief-$TODAY.md"
LOGFILE="$HOME/Library/Logs/Claude/cron.log"
TZ_NAME="America/New_York"

mkdir -p "$OUTDIR"
mkdir -p "$(dirname "$LOGFILE")"

# --- Gmail window (FIXED: timezone is explicit, so we match the user's
#     actual overnight window instead of drifting to UTC) ----------------
WINDOW_START="yesterday 23:59 ${TZ_NAME}"
WINDOW_END="today 06:30 ${TZ_NAME}"

# Ask Claude (headless) for overnight unread mail in the local-time window.
MESSAGES="$(claude --print "show me Gmail unread between '$WINDOW_START' and '$WINDOW_END' in ${TZ_NAME}" 2>>"$LOGFILE" || true)"

# --- Write the brief ---------------------------------------------------
{
  echo "# Morning brief — $TODAY"
  echo
  if [ -z "${MESSAGES// /}" ]; then
    echo "_No overnight messages in window._"
    echo "Gmail MCP returned 0 messages (window: $WINDOW_START - $WINDOW_END)" >>"$LOGFILE"
  else
    echo "$MESSAGES"
  fi
} >"$OUTFILE"

echo "Wrote $OUTFILE"
