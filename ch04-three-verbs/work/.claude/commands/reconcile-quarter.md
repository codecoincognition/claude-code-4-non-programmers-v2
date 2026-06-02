# /reconcile-quarter

Quarterly roll-up of the monthly reconciliations. No $ARGUMENTS —
operate on the most recent CLOSED quarter (the three full calendar
months before the current one, grouped into Q1=Jan-Mar, Q2=Apr-Jun,
Q3=Jul-Sep, Q4=Oct-Dec).

Read the three monthly reports for that quarter from ~/work/finance/:
  - {YYYY-MM}-reconciliation.md  (one per month in the quarter)

If any of the three monthly reports is missing, name which month is
missing and stop — do not estimate the quarter from partial data.

Produce a quarterly summary with these sections:
  - Revenue: total Stripe revenue across the quarter, by month.
  - Spend by bucket: SaaS, contractors, infra, taxes, owner draw, misc
    — quarter totals, with month-over-month trend per bucket.
  - Subscription leaks: net change across the quarter (added,
    cancelled, still-leaking), pulling from each month's leaks update.
  - Unmatched bank charges: anything still unmatched at quarter end.

Write the roll-up to:
  ~/work/finance/{quarter-YYYY-QN}-reconciliation.md

Be terse. Tables over prose. End with a one-paragraph narrative:
what the quarter's numbers say about the business.
