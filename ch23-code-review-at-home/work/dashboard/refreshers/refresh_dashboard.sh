#!/usr/bin/env bash
#
# refresh_dashboard.sh — rebuild the dashboard cache from all sources.
#
# POST-/batch version: set -euo pipefail + exit-code propagation
# (applied in Ch 23's /batch run).
#
set -euo pipefail

echo "Rebuilding dashboard cache ..."
python3 ~/work/dashboard/tools/rebuild_cache.py
RC=$?

if [[ "$RC" -ne 0 ]]; then
  echo "error: dashboard rebuild failed (rc=$RC)" >&2
  exit "$RC"
fi

echo "Dashboard cache rebuilt."
exit 0
