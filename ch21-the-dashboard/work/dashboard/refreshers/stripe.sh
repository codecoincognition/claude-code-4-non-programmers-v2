#!/usr/bin/env bash
# Refresh Stripe snapshot via the Stripe MCP.
# Writes ~/work/dashboard/data/stripe.json with mrr, new_customers,
# churn, and snapshot_ts.

set -e
OUT=~/work/dashboard/data/stripe.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# The Stripe MCP exposes weekly aggregates as a single tool call.
claude --no-interactive --tool stripe.summary_week > /tmp/stripe.raw

# Compose the snapshot file.
jq --arg ts "$TS" '
  { mrr: .mrr_cents / 100,
    new_customers: .new_customers_count,
    churn: .churned_count,
    snapshot_ts: $ts }
' /tmp/stripe.raw > "$OUT"

echo "stripe ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
