#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh.
# Reads the PreToolUse JSON payload from stdin, decides whether the
# call belongs to the watchdog at escalate tier, and (if so) requires
# typed-code confirmation. Anything else passes through.
#
# Exit codes per Claude Code hook docs:
#   exit 0 — allow the tool call (pass through)
#   exit 2 — BLOCK the tool call; stderr is surfaced to Claude
#   any other non-zero — non-blocking error (logged but does not block)

set -euo pipefail

LOG=~/work/watchdog/escalations.log
mkdir -p "$(dirname "$LOG")"

PAYLOAD=$(cat)                                  # PreToolUse sends JSON on stdin
TOOL_NAME=$(echo "$PAYLOAD" | jq -r '.tool_name // "unknown"')
MESSAGE=$(echo "$PAYLOAD" | jq -r '.tool_input.text // .tool_input.message // ""')

# Only gate watchdog-orchestrator escalate-tier sends. The orchestrator
# tags its escalate messages with a "[WATCHDOG:ESCALATE]" prefix; quiet
# notify-tier sends from the same agent don't carry the prefix and pass.
# Iris/Reuben/etc. that also use Slack but never carry the prefix also pass.
if [[ "$MESSAGE" != *"[WATCHDOG:ESCALATE]"* ]]; then
  exit 0                                        # pass through, no gate
fi

PROPOSED_ACTION="$TOOL_NAME: ${MESSAGE:0:80}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# Send the code to the user via desktop notification alongside the proposed action.
# (osascript is macOS's command-line scripting tool — it's how a shell script pops a
#  native macOS notification. On Linux substitute notify-send; on Windows substitute a
#  PowerShell toast call. See kill-switch-linux.sh / kill-switch-windows.ps1.)
osascript -e "display notification \"Watchdog wants to: $PROPOSED_ACTION. Type code $CODE to approve.\" with title \"Kill-switch\""

# Wait for the user to type the code back. Exit 2 tells Claude Code to BLOCK
# the tool call (2 is the documented blocking exit code that surfaces stderr
# to Claude).
read -r -t 60 -p "Enter 4-digit code to approve: " ENTERED || { echo "[$(date -Iseconds)] DENIED (timeout): $PROPOSED_ACTION" >> "$LOG"; echo "Kill-switch timed out" >&2; exit 2; }

if [[ "$ENTERED" == "$CODE" ]]; then
  echo "[$(date -Iseconds)] APPROVED: $PROPOSED_ACTION" >> "$LOG"
  exit 0
else
  echo "[$(date -Iseconds)] DENIED (wrong code): $PROPOSED_ACTION" >> "$LOG"
  echo "Kill-switch denied: wrong code" >&2
  exit 2
fi
