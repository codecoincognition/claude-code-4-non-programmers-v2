#!/usr/bin/env bash
# Make it yours #3 — Stop hook. Fires when Claude finishes a response.
# Prompts you (in the terminal) for a one-line note about what you approved
# this session and why, then appends it to ~/work/.claude/approvals.log.
# Never blocks (always exits 0). If there's no interactive terminal
# (unattended run), it logs a placeholder instead of hanging.

set -u
LOG="${HOME}/work/.claude/approvals.log"
mkdir -p "$(dirname "$LOG")"
TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

if [ -t 0 ] && [ -t 1 ]; then
  printf 'Approvals this session — one line, what + why (Enter to skip): ' > /dev/tty
  read -r NOTE < /dev/tty || NOTE=""
  [ -z "$NOTE" ] && NOTE="(no note)"
else
  NOTE="(non-interactive session — no note captured)"
fi

printf '%s\t%s\n' "$TS" "$NOTE" >> "$LOG"
exit 0
