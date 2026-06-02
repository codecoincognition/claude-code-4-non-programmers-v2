# fixtures/ — how the private-data inputs work

Chapter 2 is built on **your own private financial data**: a bank CSV, a Stripe
payouts export, a corporate-card statement, and (in the make-it-yours prompts) a
HubSpot contact export, a Stripe customer export, and a folder of receipts that
may include forwarded Gmail confirmations.

The companion repo **cannot and does not ship your real data.** Instead it ships
small, synthetic stand-ins so you can run every pattern end to end before
pointing it at your own exports. This file explains where each one lives and how
to swap in the real thing.

## What ships, and where

| Chapter input (private)            | Synthetic stand-in shipped                          |
|------------------------------------|-----------------------------------------------------|
| Bank statement CSV                 | `work/finance/bank-statement-2026-Q3.csv` (847 rows)|
| Stripe payouts export              | `work/finance/stripe-payouts-2026-Q3.csv` (43 rows) |
| Subscription-confirmation emails (Gmail) | `work/finance/subscription-leaks-draft.md` (already distilled to 7 rows by Chapter 1) |
| Corporate-card statement           | `work/finance/amex-2026-Q3.csv`                     |
| Last year's bank statement         | `work/finance/2025-bank-statement.csv`              |
| Receipts (PDF/photo/Gmail forward) | `work/expenses/2026-Q3/receipt-*.txt` (2 stand-ins) |
| HubSpot contact export             | `work/customers/hubspot-export.csv`                 |
| Stripe customer export             | `work/customers/stripe-customers.csv`               |

All stand-ins are synthetic — invented vendors, invented customers, invented
amounts. They are internally consistent so the reconciliation resolves the way
the chapter narrates (41 of 43 payouts match; Bolt Inc. and Acme Corp are the two
flagged anomalies).

## Why nothing private is shipped

- **Gmail receipts / subscription emails.** These live in your inbox. Chapter 1
  already turned them into `subscription-leaks-draft.md`; Chapter 2 only needs
  that draft, not the raw emails. To regenerate the draft from your own inbox,
  re-run Chapter 1 against your real Gmail.
- **HubSpot / Stripe exports.** Download these from your own dashboards
  (HubSpot → Contacts → Export; Stripe → Customers → Export). Drop them into
  `work/customers/` with the same filenames and the make-it-yours prompts work
  unchanged.
- **Real receipts.** Drop your PDFs, photos, or forwarded email confirmations
  into `work/expenses/2026-Q3/`. Claude reads vendor + date + amount out of each
  and matches them to the card statement.

## Swapping in your real data

1. Export the real CSV from your bank / Stripe / HubSpot.
2. Save it under `work/finance/` or `work/customers/` with the **same filename**
   the prompts reference.
3. Re-run the prompts from `../prompts.md`. The pattern is identical; only the
   numbers change.

Everything runs locally. See the privacy note in the chapter and in
`../README.md`.
