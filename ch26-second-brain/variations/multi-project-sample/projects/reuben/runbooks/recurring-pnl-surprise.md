# Runbook — recurring P&L surprise (the SaaS-credit timing gap)

**Project:** [[../README]]
**Status:** Active

## The recurring surprise

Reuben (Ch 11, the bookkeeper) flags the same month-end variance every quarter:
the P&L shows a margin dip that isn't real. It's a timing artifact — annual SaaS
credits land in one month while the cost they offset is spread across the year.

## How to handle it when it shows up

1. Reuben surfaces the variance and names the vendor.
2. Confirm it's the credit-timing gap, not a real cost change: check whether the
   spike matches a known annual credit.
3. If it's the timing gap, note it in the month-end summary as "timing, not a
   margin change" — do not chase it as a cost problem.
4. If it's NOT a known credit, treat it as a real variance and investigate.

## Links

- [[../README]] — Reuben, the bookkeeper
- [[../../concepts/accrual-vs-cash-timing]] — the concept underneath this
  (write this entry when you next reach for it)
