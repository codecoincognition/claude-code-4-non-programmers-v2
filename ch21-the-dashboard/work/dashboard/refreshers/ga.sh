#!/usr/bin/env bash
# Refresh Google Analytics snapshot via the GA MCP.
# Writes ~/work/dashboard/data/ga.json with sessions_daily,
# top_pages, conversions, and snapshot_ts.
# ~12 lines — same shape as stripe.sh, one tool call.

set -e
OUT=~/work/dashboard/data/ga.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# The GA MCP exposes a single weekly report tool call.
claude --no-interactive --tool ga.report_week > /tmp/ga.raw

jq --arg ts "$TS" '
  { sessions_daily: .sessions_daily,
    top_pages: .top_pages,
    conversions: .conversions_count,
    snapshot_ts: $ts }
' /tmp/ga.raw > "$OUT"

echo "ga ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
