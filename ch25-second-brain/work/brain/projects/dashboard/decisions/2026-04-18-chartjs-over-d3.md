# 2026-04-18 — Chart.js over D3 for the dashboard

**Status:** Accepted
**Project:** [[../README]]

## Context

The dashboard (Ch 21) needs four interactive charts updating nightly.
The chart library has to be small (fast page load), good enough for
non-technical viewers (Dana opens this every morning), and writable
by Claude on the first try without a learning ramp.

## Decision

Use Chart.js. Accept the trade-off: less expressive than D3, but
Claude can produce a working chart on the first prompt and Dana
will never need to interact with the source.

## Consequences

- ✅ First chart shipped in 12 minutes
- ✅ Bundle stayed under 60 KB
- ❌ Custom interactions later will need extra work
- 🔗 See [[../runbooks/daily-refresh]] for how the data lands

## Links

- [[../README]] — the dashboard project
- [[../runbooks/daily-refresh]] — what runs every night
- [[../../../patterns/static-dashboards-over-spas]] — the broader pattern
  (write this entry when you next reach for the pattern)
