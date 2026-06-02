#!/usr/bin/env bash
#
# build.sh — dashboard build script (Ch 21).
#
# This is the POST-REVIEW version: the three /simplify findings from
# Ch 23 have been applied:
#   1. set -euo pipefail at the top (was: unguarded run pattern)
#   2. command -v vercel resolution (was: hardcoded /Users/maya/.npm/bin/vercel)
#   3. exit-code propagation (was: always exited 0)
#
set -euo pipefail

# --- Resolve the vercel binary portably (fix #2) ---
VERCEL_BIN="$(command -v vercel || true)"
if [[ -z "$VERCEL_BIN" ]]; then
  echo "error: vercel not found on PATH" >&2
  exit 1
fi

# --- Refresh data sources before building (fix #1: guarded) ---
echo "Refreshing Stripe data ..."
python3 refresh_stripe.py

# --- Build the dashboard ---
echo "Building dashboard ..."
streamlit run dashboard_app.py --server.headless true &
BUILD_PID=$!
sleep 2
kill "$BUILD_PID" 2>/dev/null || true

# --- Deploy, propagating the exit code (fix #3) ---
echo "Deploying ..."
"$VERCEL_BIN" deploy --prod
DEPLOY_RC=$?

if [[ "$DEPLOY_RC" -ne 0 ]]; then
  echo "error: deploy step failed (rc=$DEPLOY_RC)" >&2
  exit "$DEPLOY_RC"
fi

echo "Build + deploy complete."
exit 0
