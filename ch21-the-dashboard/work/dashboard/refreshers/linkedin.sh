#!/usr/bin/env bash
# Refresh LinkedIn snapshot via the browser-scrape primitive from Ch 20.
# LinkedIn has no real API; the scrape is the only path.
# Writes ~/work/dashboard/data/linkedin.json.

set -e
OUT=~/work/dashboard/data/linkedin.json
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# The Ch 20 scraper drops a JSON file per day under
# ~/work/research/linkedin-snapshot/YYYY-MM-DD.json.
TODAY=$(date -u +"%Y-%m-%d")
SNAPSHOT=~/work/research/linkedin-snapshot/$TODAY.json

# Resilient fallback: if today's snapshot doesn't exist
# (the scrape may not have run, e.g., laptop was closed),
# fall back to the most recent one available. Tell the
# dashboard so it can render a freshness indicator.
FALLBACK=false
if [ ! -f "$SNAPSHOT" ]; then
  SNAPSHOT=$(ls -t ~/work/research/linkedin-snapshot/*.json | head -1)
  FALLBACK=true
  echo "linkedin ⚠ falling back to $(basename $SNAPSHOT)" \
    >> ~/work/dashboard/dashboard-deploy.log
fi

# The snapshot already has the shape the dashboard wants;
# we just stamp the actual snapshot date into the file and
# record whether a fallback was used (so the dashboard can
# render an honest freshness indicator).
SNAP_TS=$(jq -r '.snapshot_ts' "$SNAPSHOT")
jq --arg ts "$SNAP_TS" --argjson fb "$FALLBACK" \
  '. + { snapshot_ts: $ts, fallback_used: $fb }' "$SNAPSHOT" > "$OUT"

echo "linkedin ✓ $(date) (snapshot: $SNAP_TS)" \
  >> ~/work/dashboard/dashboard-deploy.log
