---
name: dashboard-refresh
description: >
  Manually rebuild and redeploy the dashboard. Runs build.sh and
  reports the deploy URL. Use when you want fresh numbers between
  scheduled nightly builds.
allowed-tools:
  - Bash
---

# Dashboard refresh

Run ~/work/dashboard/build.sh, capture the output, and report the
deploy URL. If any refresher fails, surface that in the response.
