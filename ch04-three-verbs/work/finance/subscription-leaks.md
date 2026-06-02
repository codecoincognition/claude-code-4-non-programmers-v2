# Subscription leaks

Recurring charges spotted on the bank statement. Reviewed monthly during
`/reconcile`. The goal: catch subscriptions we forgot we were paying for.

| Service | Monthly | First seen | Status | Notes |
|---|---|---|---|---|
| GitHub | $21.00 | 2025-03 | active | core tooling, keep |
| Notion | $16.00 | 2025-01 | active | docs + wiki, keep |
| Slack | $87.50 | 2025-01 | active | team comms, keep |
| Figma | $45.00 | 2025-06 | active | design, keep |
| Google Workspace | $36.00 | 2025-01 | active | email + drive, keep |
| Zoom | $21.99 | 2025-02 | active | client calls, keep |
| Adobe CC | $59.99 | 2025-04 | review | only used for occasional exports — downgrade? |
| Linear | $32.00 | 2025-08 | active | issue tracking, keep |
| Vercel | $20.00 | 2025-05 | active | hosting, keep |
| Headspace | $12.99 | 2025-07 | active | wellness perk — is anyone using it? |

<!--
NOTE FOR THE READER: this file is wired so /reconcile produces the exact
result the chapter shows. When you run /reconcile against bank-2026-10.csv:
  - Headspace ($12.99) does NOT appear in October's bank file → marked (cancelled?)
  - Buffer ($15.00) appears in the bank file but is NOT yet in this table → added as a new row
-->
