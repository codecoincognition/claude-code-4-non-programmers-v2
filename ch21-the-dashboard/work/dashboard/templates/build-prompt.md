# Build the dashboard page

You are composing a single static `index.html` for Maya's company
dashboard. Read the six JSON snapshots and inline their data into the
page. Do NOT add any fetch/XHR calls — the page must be a frozen render
of the snapshots, with the JSON inlined into the page at build time.

## Inputs (read each one)

- `data/stripe.json`    — { mrr, new_customers, churn, snapshot_ts }
- `data/ga.json`        — { sessions_daily[14], top_pages[], conversions, snapshot_ts }
- `data/linkedin.json`  — { followers, top_posts[3], engagement[], snapshot_ts, fallback_used }
- `data/bank.json`      — { cash_usd, monthly_burn, runway_months, snapshot_ts }
- `data/notion.json`    — { okrs:[{name,percent_complete,owner}], snapshot_ts }
- `data/nps.json`       — { score, respondents, snapshot_ts }

## Layout (3 rows)

- **Row 1 — KPI cards (4, full width):** MRR · New customers · Churn · Runway.
- **Row 2 — charts (2 columns):** Weekly traffic line chart (GA sessions/day,
  14 days) · LinkedIn engagement bar (top 3 posts of the week).
- **Row 3 — mixed (3 columns):** NPS gauge · OKR progress (3 bars) ·
  Top GA pages list.

## Rendering rules

- Use **Chart.js** loaded from CDN. One `<canvas>` per chart, one short
  `<script>` block at the bottom binding each canvas to its inlined JSON.
- Match the Ch 19 design system: dark navy (`#1a2238`) and warm cream
  (`#f5f0e6`). Cards have rounded corners and a soft shadow.
- **Freshness footer on every card and chart.** Read `snapshot_ts` from the
  source's JSON and render "data from YYYY-MM-DD HH:MM UTC" beneath each tile.
- If a source's `snapshot_ts` is **more than 24h old**, render a small yellow
  bar above that tile with the actual date and an "X days old" label.
- If it is **more than 72h old**, render that bar in **red** instead.
- For LinkedIn: if `fallback_used` is true AND the snapshot is more than 24h
  old, the indicator text includes
  "(scrape did not run yesterday — fallback to most recent)".

## Output

Write the complete HTML document to stdout. ~80 lines including the Chart.js
bindings. No external CSS file — inline a `<style>` block. No backend, no
load-time API calls.
