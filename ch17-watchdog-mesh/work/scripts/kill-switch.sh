#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh.
# Intercepts escalate-tier actions; requires typed-code confirmation.

set -euo pipefail

LOG=~/work/watchdog/escalations.log
PROPOSED_ACTION="${1:-unspecified}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# Send the code to the user via desktop notification alongside the proposed action.
# (osascript is macOS's command-line scripting tool — it's how a shell script pops a native macOS notification.
#  On Linux substitute notify-send; on Windows substitute a PowerShell toast call. See kill-switch-linux.sh / kill-switch-windows.ps1.)
osascript -e "display notification \"Watchdog wants to: $PROPOSED_ACTION. Type code $CODE to approve.\" with title \"Kill-switch\""

# Wait for the user to type the code back.
read -r -t 60 -p "Enter 4-digit code to approve: " ENTERED || { echo "[$(date -Iseconds)] DENIED (timeout): $PROPOSED_ACTION" >> "$LOG"; exit 1; }

if [[ "$ENTERED" == "$CODE" ]]; then
  echo "[$(date -Iseconds)] APPROVED: $PROPOSED_ACTION" >> "$LOG"
  exit 0
else
  echo "[$(date -Iseconds)] DENIED (wrong code): $PROPOSED_ACTION" >> "$LOG"
  exit 1
fi
