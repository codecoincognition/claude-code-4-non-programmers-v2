#!/usr/bin/env bash
# pre-deploy.sh — local build guard rail (Step 10)
# Runs the build locally so a missing-dependency bug fails fast in
# your own terminal instead of in production at 10 PM. The Stop hook
# calls this BEFORE `vercel deploy`; a non-zero exit blocks the deploy.
set -euo pipefail

echo "==> pre-deploy: installing dependencies"
npm install

echo "==> pre-deploy: running build"
npm run build

echo "==> pre-deploy: build green. Safe to deploy."
