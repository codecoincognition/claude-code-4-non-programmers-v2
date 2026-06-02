# Fixtures — input shapes for the dashboard's six (+1) sources

The dashboard never calls APIs at load time. It reads the JSON snapshot
files under `work/dashboard/data/`. Those snapshots are written by the
refresher scripts, which pull from the reader's own accounts and apps.
Because that data is private, this folder documents the **input shape** of
each source plus a small synthetic sample where useful. Swap in your own
accounts/credentials and the same refreshers produce real snapshots.

## The six sources

| Source | How the refresher gets it | Input shape | Output snapshot |
|---|---|---|---|
| Stripe | Stripe MCP, `stripe.summary_week` | `{ mrr_cents, new_customers_count, churned_count }` | `data/stripe.json` |
| Google Analytics | GA MCP, `ga.report_week` | `{ sessions_daily[14], top_pages[], conversions_count }` | `data/ga.json` |
| LinkedIn | reads the Ch 20 scrape file on disk | `work/research/linkedin-snapshot/YYYY-MM-DD.json` | `data/linkedin.json` |
| Bank | plain CSV the reader drops weekly | `work/finance/bank-current.csv` (`cash_usd,monthly_burn`) | `data/bank.json` |
| Notion (OKRs) | Notion MCP, `notion.read_okr_page` | `{ okrs:[{name,percent_complete,owner}] }` | `data/notion.json` |
| NPS | plain read of a survey `.xlsx` | `~/work/research/nps.xlsx` (`rating` column, 0–10) | `data/nps.json` |

A seventh source — **Leads funnel** (`leads.sh`) — slots in two weeks after
the Ch 19 launch starts capturing leads. It queries the Notion Leads DB via
the Notion MCP and writes `data/leads.json`.

## Synthetic samples in this repo

- `work/finance/bank-current.csv` — real CSV the bank refresher reads.
- `work/research/linkedin-snapshot/2026-05-07.json` and `2026-05-09.json` —
  two days of Ch 20 scrape output. The two dates let you exercise the
  stale-data fallback: delete today's file and `linkedin.sh` falls back to
  the most recent one (the When-it-goes-wrong demo).
- `work/research/nps.sample.csv` — 47 NPS responses. The chapter's source is
  an `.xlsx`; this CSV holds the same numbers (NPS ≈ 58) so you can test
  without a spreadsheet. Save it as `nps.xlsx`, or point `nps.sh` at the CSV.
- `work/dashboard/data/*.json` — pre-filled snapshots matching the chapter's
  first-run numbers, so `index.html` renders before you run any refresher.

## Sources you must supply yourself

Stripe, Google Analytics, and Notion data come through MCPs connected to the
reader's own accounts — there is no synthetic stand-in for live financials or
analytics. Connect those MCPs (Ch 5) and the refreshers fill in the snapshots.
