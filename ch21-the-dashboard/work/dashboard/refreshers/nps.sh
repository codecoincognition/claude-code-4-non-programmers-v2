#!/usr/bin/env bash
# Refresh NPS snapshot from the survey spreadsheet.
# Reads ~/work/research/nps.xlsx, computes the NPS score,
# writes ~/work/dashboard/data/nps.json. ~12 lines.
#
# NPS = % promoters (score 9-10) minus % detractors (score 0-6).

set -e
XLSX=~/work/research/nps.xlsx
OUT=~/work/dashboard/data/nps.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Use Claude to read the xlsx and emit {score, respondents} JSON.
# (Plain file-read: no MCP, no network. Claude reads the sheet,
# computes promoters/detractors, returns the NPS number.)
claude --print --no-interactive \
  "Read $XLSX. The 'rating' column holds 0-10 NPS responses. \
Compute NPS = pct(9-10) - pct(0-6), rounded to the nearest \
integer. Output ONLY compact JSON: {\"score\": N, \"respondents\": M}" \
  > /tmp/nps.raw

jq --arg ts "$TS" '. + { snapshot_ts: $ts }' /tmp/nps.raw > "$OUT"

echo "nps ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
