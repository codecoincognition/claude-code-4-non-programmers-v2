# ~/work/finance/contracts/ — sample vendor-agreement folder

This folder is the second contract location the chapter mentions in Step 5:
*"Some weeks Maya runs it on `~/work/legal/`, some weeks on
`~/work/finance/contracts/` (her vendor agreements)."*

It's the input that `/renewals finance/contracts` scans, and one of the two
locations `/renewals all` (Make-it-yours #4) merges.

## What's here

| File | Counterparty | Type | Renewal date | Annual value |
|---|---|---|---|---|
| `vercel-pro-agreement.md` | Vercel Inc. | Service (auto-renew) | 2026-12-15 | $240 |
| `aws-savings-plan.md` | Amazon Web Services | Commitment (no auto-renew) | 2027-02-20 | $3,600 |

These are synthetic vendor agreements, separate from the *client* contracts
in `~/work/legal/`. Running `/renewals finance/contracts` produces a two-row
table; running `/renewals all` merges these with the three `~/work/legal/`
rows into one view with a "Source" column.
