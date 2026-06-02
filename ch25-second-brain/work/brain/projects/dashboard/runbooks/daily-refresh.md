# Runbook — daily refresh

**Project:** [[../README]]
**Status:** Active

## What it does

Every night the dashboard's data file is regenerated so the page Dana opens at
seven shows yesterday's numbers. The page itself is static; only the data file
changes.

## How it runs

1. A scheduled job fires at **3:00 AM** (the same cron pattern the rest of the
   Ch 21 build uses).
2. The job pulls the latest figures, writes them to `data/dashboard.json` next
   to the page.
3. No deploy step — the page reads the JSON fresh on the next load. Dana's
   morning open at 7:00 AM picks it up automatically.

## What to check if it fails

- **Stale numbers in the morning.** Confirm the JSON's timestamp. If it still
  reads yesterday, the 3:00 AM job did not run — check the scheduler log first.
- **Charts render blank.** The JSON is malformed or missing. Open
  `data/dashboard.json` and validate it; a partial write is the usual cause.
- **Page loads but one chart is empty.** That chart's data key is missing from
  the JSON. Check the export step produced all four keys (revenue, pipeline,
  active-clients, runway).
- **Job ran but numbers look wrong.** Re-run the export by hand and diff against
  the source-of-truth before assuming a dashboard bug — see [[../debug-log]].

## Links

- [[../README]] — the dashboard project
- [[../decisions/2026-04-18-chartjs-over-d3]] — why Chart.js renders the JSON
- [[../debug-log]] — failures we've already seen
