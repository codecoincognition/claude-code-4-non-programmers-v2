# Chapter 21 — The dashboard that replaced six browser tabs

This chapter builds a self-refreshing stakeholder dashboard: one static HTML
page at a bookmarkable URL that aggregates six (later seven) data sources —
Stripe, Google Analytics, LinkedIn, the bank, Notion OKRs, and NPS — into a
coherent picture. Each source is refreshed into a small JSON snapshot file by
its own tiny script; a `build.sh` runs all the refreshers in sequence,
regenerates `index.html` from the snapshots (with Chart.js bindings), and
redeploys to Vercel. The build is scheduled nightly with plain English
("refresh every night at 3 AM"), and every chart surfaces its own freshness
so stale data is never silent. The architecture is **live data app via
per-source snapshot refreshers**: many sources, one snapshot per source, no
load-time API calls — robust to any one source failing, cheap to host, and
fully understandable from one build script.

## Files

```
ch21-the-dashboard/
├── README.md                        ← this file
├── prompts.md                       ← every chapter prompt, verbatim and in order
├── fixtures/
│   └── README.md                    ← input shapes for each source + sample data notes
└── work/
    ├── .claude/commands/
    │   └── dashboard-refresh.md      ← slash command for manual "build now"
    ├── finance/
    │   └── bank-current.csv          ← sample bank CSV (cash, monthly burn)
    ├── research/
    │   ├── linkedin-snapshot/
    │   │   ├── 2026-05-07.json       ← Ch 20 scrape output (today)
    │   │   └── 2026-05-09.json       ← Ch 20 scrape output (for fallback demo)
    │   └── nps.sample.csv            ← 47 NPS responses (rename to nps.xlsx)
    └── dashboard/
        ├── build.sh                  ← nightly build: refresh → regenerate → deploy
        ├── index.html                ← reference render (regenerated each build)
        ├── dashboard-deploy.log      ← append-only build log (sample entries)
        ├── templates/
        │   └── build-prompt.md       ← prompt that composes index.html from snapshots
        ├── data/                     ← JSON snapshots (one per source)
        │   ├── stripe.json
        │   ├── ga.json
        │   ├── linkedin.json
        │   ├── bank.json
        │   ├── notion.json
        │   ├── nps.json
        │   └── leads.json            ← 7th source (launch funnel)
        └── refreshers/               ← one script per source
            ├── stripe.sh
            ├── ga.sh
            ├── linkedin.sh
            ├── bank.sh
            ├── notion.sh
            ├── nps.sh
            └── leads.sh              ← 7th refresher (launch funnel)
```

## How to use

1. **See the dashboard immediately.** Open `work/dashboard/index.html` in a
   browser. The snapshots in `data/` are pre-filled with the chapter's
   first-run numbers, so the page renders without running anything.

2. **Wire up your own sources.** Connect the Stripe, GA, and Notion MCPs
   (Ch 5). Drop your bank export at `work/finance/bank-current.csv`. Save
   your NPS export as `work/research/nps.xlsx`. Point the LinkedIn refresher
   at your Ch 20 scrape output directory. See `fixtures/README.md` for each
   source's input shape.

3. **Run a build.** `bash work/dashboard/build.sh` runs all refreshers,
   regenerates `index.html`, and (if the Vercel CLI is authenticated from
   Ch 19) deploys. Watch `dashboard-deploy.log` for per-source status.

4. **Schedule it (plain English).** Tell Claude "this needs to refresh every
   night at 3 AM" — Claude picks the `/schedule` primitive and registers the
   cron job (`0 3 * * *`). For a stakeholder-facing dashboard, run the build
   on an always-on host (Mac mini or a $5/mo VPS); a closed laptop won't fire
   the 3 AM job.

5. **Manual build now.** Say "refresh the dashboard" (or `/dashboard-refresh`)
   to run `build.sh` on demand before a meeting.

6. **Try the stale-data demo.** Delete today's LinkedIn snapshot, rerun
   `build.sh`, and watch `linkedin.sh` fall back to the most recent file —
   then see the yellow "X days old" indicator render on the page.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 21 walks you through building.
