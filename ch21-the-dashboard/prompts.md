# Chapter 21 — Prompts, verbatim and in order

Every prompt the chapter has you give Claude, in the order they appear.

---

## Step 1 — Wireframe and snapshot shapes (before any code)

> I want a dashboard at dashboard.maya-consulting.com. Six data sources: Stripe (MRR, new customers, churn), Google Analytics (traffic, top pages, conversions), LinkedIn (followers, post engagement, top 3 posts — use the browser-scrape primitive from Ch 20 since LinkedIn has no API), bank (CSV at ~/work/finance/bank-current.csv), Notion (the OKR page; tell me which one if there's more than one), NPS (spreadsheet at ~/work/research/nps.xlsx). One page, Chart.js, design system from Ch 19's site. Don't build yet — first show me the wireframe and tell me what each data source's snapshot will look like as JSON.

## Step 2 — Six refreshers, one per data source

> OKR page is "Q3 OKRs — Team". Wireframe looks good. Now build the refreshers — one per data source. Each one writes its JSON to ~/work/dashboard/data/{source}.json, with a snapshot_ts field. Show me the Stripe and LinkedIn refresher in full; summarize the others.

## Step 3 — Compose build.sh

> Now compose build.sh — runs all six refreshers in sequence, regenerates index.html from the snapshot data, and deploys to Vercel. If any refresher fails, the build still succeeds with the last-known data and writes a warning to dashboard-deploy.log. Show me build.sh in full.

## Step 4 — First manual run

> Run build.sh now. Walk me through what's happening.

## Step 5 — Schedule the build (plain English)

> This needs to refresh every night at 3 AM. Schedule it.

## Step 6 — The always-on hint

> Wait — does the schedule fire if my laptop is closed?

## Step 7 — A slash command for manual runs

> Sometimes I want to push a build before the meeting starts. Give me a way to trigger it manually with one command.

## Step 8 — Forward-pointer to the next chapter

> What's the next chapter going to teach me, and is it shaped like this one?

---

## When it goes wrong — the silent stale data

> The LinkedIn data was two days stale this morning and my co-founder didn't know. Three fixes: (1) surface stale-data warnings ON the dashboard, not just in the log — every chart that's reading data older than 24 hours gets a small yellow indicator with the actual snapshot date; (2) the LinkedIn refresher already falls back gracefully — make sure it writes the actual snapshot date to the JSON so the dashboard can render the indicator from real data, not from when the build ran; (3) for any data source that fails, the dashboard's per-card freshness indicator should show the actual snapshot timestamp so my co-founder knows what he's looking at.

---

## Make it yours

**1. Portfolio dashboard.**

> Build me a dashboard at portfolio.maya-consulting.com that reads from a brokerage CSV at ~/work/finance/brokerage.csv, a crypto wallet API, and a watchlist of stocks. Refresh every weekday at market close. Same Chart.js, same design system, freshness indicators on every chart.

**2. Customer health dashboard.**

> Build a dashboard for my top 20 customers, one card each, with usage trend (from our analytics), last support ticket (from Linear), NPS (from the same spreadsheet as above), and time since last login. Refresh nightly.

**3. Team KPI dashboard.**

> Build a dashboard for my team's Notion task DB (or Asana, Linear, Jira if that's what your reader uses), on-call rotation, and CI build status (CI = continuous integration — the automated system that tests and builds your code on every change). Refresh every six hours during the workday.

**4. Regulatory watch dashboard.**

> Build a dashboard that scrapes the SEC filings page, the FTC press releases page, and a list of state AG sites for new rulings affecting our industry. Refresh nightly. Each page is a Ch 20 browser-scrape job, since these sites have no APIs.

**5. Daily Slack post.**

> Every morning at 7 AM, post a screenshot of the dashboard to my co-founder's DM with a one-paragraph summary of what changed since yesterday. The dashboard is the artifact; this is the daily prompt for him to look at it.

**6. A/B test winner by conversion.**

> Add a Leads-funnel row to the dashboard. Three tiles: conversion-rate-by-day (30-day line), leads-by-source (stacked bar), and top-converting-CTA (the winning A/B test variant by conversion rate, with confidence interval — only call a winner once each variant has at least 500 page views per the Ch 19 calibration). Read the Notion Leads DB and the PostHog events from the Ch 19 stack.

---

## Test yourself in 60 seconds

1. > Run my dashboard-refresh command and tell me which source took longest and which one's freshness indicator is yellow.
2. > Open ~/work/dashboard/dashboard-deploy.log and tell me whether last night's build succeeded.
3. > Show me what's scheduled and confirm the dashboard nightly build runs at 3 AM.

Stuck?

> audit my Chapter 21 setup against the chapter spec
