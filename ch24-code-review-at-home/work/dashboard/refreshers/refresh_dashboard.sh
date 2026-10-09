#!/usr/bin/env bash
#
# refresh_dashboard.sh — rebuild the dashboard cache from all sources.
#
# POST-review version: set -euo pipefail + exit-code propagation
# (applied per file in Ch 24; six similar tweaks are below /batch's threshold).
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
