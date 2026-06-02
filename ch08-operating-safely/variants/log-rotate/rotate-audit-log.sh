#!/usr/bin/env bash
# The lift — audit logs grow. This rotates ~/work/.claude/audit.log monthly:
# renames the current log to audit-{YYYY-MM}.log, gzips it, and starts a
# fresh empty audit.log. Cron it monthly (see crontab line below).
#
# Install (run once):  chmod +x ~/work/scripts/rotate-audit-log.sh
# Schedule monthly via cron — edit your crontab with `crontab -e` and add:
#   0 3 1 * * ~/work/scripts/rotate-audit-log.sh
# (3:00 AM on the 1st of every month)

set -u
LOG="${HOME}/work/.claude/audit.log"
MONTH="$(date -u +"%Y-%m")"

[ -f "$LOG" ] || { echo "No audit.log to rotate."; exit 0; }

ARCHIVE="${HOME}/work/.claude/audit-${MONTH}.log"
mv "$LOG" "$ARCHIVE"
gzip -f "$ARCHIVE"
: > "$LOG"   # start a fresh, empty audit.log

echo "Rotated audit.log -> ${ARCHIVE}.gz; fresh log started."
exit 0
