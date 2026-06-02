#!/usr/bin/env bash
# Refresh launch-funnel snapshot via the Notion MCP. (The 7th
# refresher, slotted in two weeks after the Ch 19 launch starts
# capturing leads.) Queries the Notion Leads DB for rows from the
# last 30 days, groups by utm_source / utm_campaign, joins against
# the Notion CRM to compute conversion rate per campaign, and writes
# three tiles' worth of data to ~/work/dashboard/data/leads.json:
#   - conversion_rate_by_day  (30-day line chart)
#   - leads_by_source         (stacked bar: linkedin-paid, organic,
#                              twitter, direct)
#   - top_converting_cta      (winning A/B variant by conversion rate,
#                              only when each variant has >=500 views)
# ~15 lines — same shape as the others.

set -e
OUT=~/work/dashboard/data/leads.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

claude --no-interactive --tool notion.leads_funnel_30d > /tmp/leads.raw

jq --arg ts "$TS" '
  { conversion_rate_by_day: .conversion_rate_by_day,
    leads_by_source: .leads_by_source,
    top_converting_cta: .top_converting_cta,
    snapshot_ts: $ts }
' /tmp/leads.raw > "$OUT"

echo "leads ✓ $(date)" >> ~/work/dashboard/dashboard-deploy.log
