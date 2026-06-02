#!/usr/bin/env bash
#
# morning-brief.sh — writes a daily brief of overnight Gmail to a dated
# markdown file. (This is a teaching stub for the Chapter 6 debugging
# demo; the real version is built in Chapter 7.)
#
# KNOWN BUG (the one the debugging skill diagnoses in Chapter 6):
#   On Wednesdays the brief comes out empty. The Gmail query window is
#   computed in UTC instead of the user's local timezone, so on the
#   Tue->Wed date boundary the "yesterday 23:59 -> today 06:30" window
#   lands inside the wrong UTC calendar day and matches 0 messages.
#   Fix: pass an explicit timezone (America/New_York) to the Gmail query.

set -euo pipefail

TODAY="$(date +%Y-%m-%d)"
OUTDIR="$HOME/work/briefs"
OUTFILE="$OUTDIR/brief-$TODAY.md"
LOGFILE="$HOME/Library/Logs/Claude/cron.log"

mkdir -p "$OUTDIR"

# --- Gmail window (BUGGY: no explicit timezone, drifts to UTC) ---------
# Intended window: yesterday 23:59 local -> today 06:30 local.
WINDOW_START="yesterday 23:59"
WINDOW_END="today 06:30"

# Ask Claude (headless) for overnight unread mail in the window.
# NOTE: the missing `--tz America/New_York` here is the root cause.
MESSAGES="$(claude "show me Gmail unread between '$WINDOW_START' and '$WINDOW_END'" 2>>"$LOGFILE" || true)"

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
