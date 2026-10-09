#!/usr/bin/env bash
#
# refresh_bank.sh — ingest the bank CSV into the dashboard cache.
#
# POST-review version: set -euo pipefail + exit-code propagation
# (applied per file in Ch 24; six similar tweaks are below /batch's threshold).
#
set -euo pipefail

CSV="${HOME}/work/dashboard/inbox/bank.csv"

if [[ ! -f "$CSV" ]]; then
  echo "error: bank CSV not found at $CSV" >&2
  exit 1
fi

echo "Ingesting bank CSV ..."
python3 ~/work/dashboard/tools/ingest_bank.py "$CSV"
RC=$?

if [[ "$RC" -ne 0 ]]; then
  echo "error: bank ingest failed (rc=$RC)" >&2
  exit "$RC"
fi

echo "Bank data refreshed."
exit 0
