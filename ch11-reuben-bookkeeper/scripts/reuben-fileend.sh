#!/usr/bin/env bash
# Runs at the end of any session. Files the previous month's P&L
# the first time it runs in a new calendar month.

set -u
LOG="${HOME}/work/books/filing-log.md"
BOOKS="${HOME}/work/books"
mkdir -p "$BOOKS"
touch "$LOG"

# What's the previous calendar month?
PREV_MONTH="$(date -v-1m +%Y-%m 2>/dev/null || date -d 'last month' +%Y-%m)"
PNL="${BOOKS}/pnl-${PREV_MONTH}.md"

# Already filed this month? Bail.
if grep -q "filed: pnl-${PREV_MONTH}" "$LOG" 2>/dev/null; then
  exit 0
fi

# P&L exists? Note the filing.
if [[ -f "$PNL" ]]; then
  printf '%s\tfiled: pnl-%s\n' "$(date -u +%FT%TZ)" "$PREV_MONTH" >> "$LOG"
fi
exit 0
