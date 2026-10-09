# /reconcile

Read every CSV in ~/work/finance/ that matches:
  - bank-*.csv  (the latest by date is the one to reconcile)
  - stripe-*.csv (the latest by date)

Reconcile the bank charges against Stripe revenue:
  - Match every Stripe charge to a bank deposit by amount + date.
  - Flag any bank charge that doesn't correspond to a Stripe customer.
  - Group the remaining bank charges into spend buckets:
    SaaS, contractors, infra, taxes, owner draw, misc.

Open ~/work/finance/subscription-leaks.md.
For each subscription in the leaks file, confirm it still
appeared on this month's bank statement. If a subscription
DIDN'T appear, mark it (cancelled?) in the file.
If a NEW recurring charge appeared, add it as a row.

Write the full report to:
  ~/work/finance/{current-month-YYYY-MM}-reconciliation.md

Format: 4 sections — matched, unmatched, spend buckets, leaks update.
Be terse. One line per row in tables. No commentary, no preamble.
