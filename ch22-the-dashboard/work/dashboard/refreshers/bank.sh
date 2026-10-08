#!/usr/bin/env bash
# Refresh bank snapshot from the weekly CSV Maya drops.
# Reads ~/work/finance/bank-current.csv, computes runway,
# writes ~/work/dashboard/data/bank.json. ~14 lines.

set -e
CSV=~/work/finance/bank-current.csv
OUT=~/work/dashboard/data/bank.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# CSV columns: cash_usd,monthly_burn  (one data row under the header)
read -r CASH BURN < <(tail -n +2 "$CSV" | head -1 | awk -F',' '{print $1, $2}')

# Runway in whole months = cash / monthly burn.
RUNWAY=$(awk -v c="$CASH" -v b="$BURN" 'BEGIN { printf "%d", c / b }')

jq -n --argjson cash "$CASH" --argjson burn "$BURN" \
      --argjson runway "$RUNWAY" --arg ts "$TS" \
  '{ cash_usd: $cash, monthly_burn: $burn,
     runway_months: $runway, snapshot_ts: $ts }' > "$OUT"

echo "bank ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
