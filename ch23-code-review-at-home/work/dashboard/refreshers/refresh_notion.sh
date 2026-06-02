#!/usr/bin/env bash
#
# refresh_notion.sh — pull Notion content into the dashboard cache.
#
# POST-/batch version: set -euo pipefail at top + propagate $? from the
# notion CLI (applied across all six refreshers in Ch 23's /batch run).
#
set -euo pipefail

echo "Refreshing Notion data ..."
notion export --database content --out ~/work/dashboard/cache/notion.json
RC=$?

if [[ "$RC" -ne 0 ]]; then
  echo "error: notion refresh failed (rc=$RC)" >&2
  exit "$RC"
fi

echo "Notion data refreshed."
exit 0
