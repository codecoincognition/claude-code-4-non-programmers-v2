#!/usr/bin/env bash
# Refresh Notion OKR snapshot via the Notion MCP.
# Reads the "Q3 OKRs — Team" page, writes
# ~/work/dashboard/data/notion.json. ~10 lines.

set -e
OUT=~/work/dashboard/data/notion.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# One tool call to the Notion MCP for the chosen OKR page.
claude --no-interactive --tool notion.read_okr_page \
  --arg page "Q3 OKRs — Team" > /tmp/notion.raw

jq --arg ts "$TS" '{ okrs: .okrs, snapshot_ts: $ts }' \
  /tmp/notion.raw > "$OUT"

echo "notion ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
