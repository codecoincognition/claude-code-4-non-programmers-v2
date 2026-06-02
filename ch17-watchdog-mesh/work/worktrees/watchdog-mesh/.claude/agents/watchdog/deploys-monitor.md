---
name: deploys-monitor
description: >
  Watches everything in production across three signal sources —
  the Vercel/Netlify deploy log for the website (Ch 19), the
  nightly cron build log for the dashboard (Ch 21), and the
  Buffer queue for launch posts (Ch 16). One tier per source;
  returns the highest.
tools:
  - Bash
  - Read
  - mcp__buffer
---

# Deploys Monitor

## What to watch for

This monitor watches three independent signal sources. Each gets
its own per-source rubric — "the build failed" does not mean the
same thing in Vercel, cron, and Buffer. Classify each source, then
return the highest tier across all three.

- **vercel** — read the Vercel deploy log (`vercel ls`, authenticated
  from Ch 19 Step 0). A `queued` or `building` state is normal until
  it has been running too long. Only `error` is terminal-bad.
- **dashboard** — read the nightly cron build log. Check the last
  cron exit code and whether the latest run is inside the expected
  window.
- **buffer** — read the Buffer queue. A `queued` post before its
  scheduled time is normal — that is what scheduled posts do.

## Tier rubric (per signal source)

| Source    | Tier      | Signal                                              |
|-----------|-----------|-----------------------------------------------------|
| vercel    | all_clear | No active deploys, or all in "ready".               |
|           | log_only  | A queued or building deploy younger than 10 min.    |
|           | notify    | A deploy in "building" past 10 min.                 |
|           | escalate  | A deploy in "error" state.                          |
| dashboard | all_clear | Last cron run exited 0; latest within window.       |
|           | log_only  | Cron skipped one window but next due within 24h.    |
|           | notify    | Cron exited non-zero once.                          |
|           | escalate  | Cron exited non-zero twice in a row.                |
| buffer    | all_clear | All scheduled posts queued and on time.             |
|           | log_only  | A queued post within 60 min of slot.                |
|           | notify    | A post failed but is auto-retried.                  |
|           | escalate  | A post past its scheduled time AND Buffer reports a |
|           |           | non-200 response.                                   |

## Optional source: funnel-anomaly

Add this source when watching launch performance (Ch 19 Notion Leads
DB + Ch 16 launch crew). Signal: count rows in the Leads DB where
`Submitted At > now() - 24h`, joined against the launch-fired
timestamp in `~/work/launches/last-fire.log`.

| Source | Tier      | Signal                                                  |
|--------|-----------|---------------------------------------------------------|
| funnel | all_clear | At least 1 new lead row in the last 24h OR no launch     |
|        |           | fired in the last 48h.                                  |
|        | log_only  | A new launch fired 6-24h ago and no lead rows yet       |
|        |           | (still inside expected window).                         |
|        | notify    | A new launch fired 24h ago, fewer than 3 leads,         |
|        |           | conversion rate <10% of trailing 4-week median.         |
|        | escalate  | A new launch fired 24h ago and ZERO lead rows in the    |
|        |           | Notion Leads DB.                                        |

## Calibration discipline

False positives at the escalate tier erode trust faster than missed
escalations erode safety. Review this rubric quarterly. Tighten the
escalate boundary when a false positive happens; loosen it when you
missed a real one. Never use one rubric for all sources.

## Return

Return the highest tier across all sources. If notify or escalate,
include the source name, a one-line reason, and the recommended
human action.
