# Fixtures — inputs that come from your own apps

Most of Reuben's input is the `transactions.csv` you export from your own
bank (a real file you download). The chapter's **Marketing-section extension**
(Step 3) pulls one additional input from a Notion database that your Chapter 19
landing page writes to. We do **not** ship anyone's private Notion data here —
instead this folder documents the input *shape* so you can wire your own, plus
a tiny synthetic sample.

## 1. The bank transactions CSV (the main input)

This is real and ships: `../data/transactions.csv.sample`. Format:

```
date,amount,description,bank_category
2026-04-03,5369.32,Client invoice payment,Income
2026-04-08,-1847.22,Flights + hotel — SF client trip,Travel
```

- `date` — ISO `YYYY-MM-DD`. Reuben groups by `YYYY-MM` (the first 7 chars).
- `amount` — signed. Positive = inflow, negative = outflow.
- `description` — free text, used by the agent for categorization.
- `bank_category` — the bank's own guess. The agent re-categorizes.

Copy it into your workspace to follow the chapter live:

```bash
cp data/transactions.csv.sample ~/work/data/transactions.csv
```

## 2. The Notion Leads database (Marketing extension only)

The Chapter 19 landing page captures each form submission into a Notion
"Leads" database. Reuben reads it through the Notion MCP — there is no file
to ship. The columns the extension prompt expects:

| Column         | Type   | Example                |
|----------------|--------|------------------------|
| `Name`         | title  | Jane Doe               |
| `Email`        | email  | jane@example.com       |
| `Submitted`    | date   | 2026-04-12             |
| `utm_source`   | select | linkedin-paid          |
| `utm_campaign` | select | 2026-q2-linkedin       |
| `Status`       | select | discovery-call / paid  |

Reuben filters rows where `Submitted` falls in the target month, groups by
`utm_source` + `utm_campaign`, and counts leads per source.

If you don't have the landing page yet, the Marketing section simply doesn't
appear — the rest of the P&L is unaffected.

## 3. The ad-spend CSV (Marketing extension only)

This one is a small file you maintain by hand. A synthetic sample ships at
`../data/ad-spend-2026-04.csv`:

```
campaign,utm_source,utm_campaign,spend
LinkedIn Q2 push,linkedin-paid,2026-q2-linkedin,1200.00
```

The deterministic side divides `spend` by the lead count from the Notion
query to produce cost-per-lead. The agent narrates; it never recomputes.
