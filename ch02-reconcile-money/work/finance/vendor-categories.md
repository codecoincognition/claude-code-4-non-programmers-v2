# vendor-categories (one correction per line; Claude reads this at the start of each reconciliation)

This file fixes vendor-name drift. The same vendor can show up as `STRIPE`,
`Stripe Inc.`, and `STRIPE PAYOUT` across different bank lines. Put the vendor
name on the left and the spend bucket (or canonical name) on the right. You make
each correction once; from then on, tell Claude:

> "Read ~/work/finance/vendor-categories.md first, then reconcile."

| vendor pattern (as it appears on the bank line) | bucket / canonical name |
|--------------------------------------------------|-------------------------|
| STRIPE PAYOUT                                    | revenue (not spend)     |
| GUSTO PAYROLL                                    | payroll                 |
| AWS CLOUD SERVICES                               | infrastructure          |
| ADOBE CREATIVE CLOUD                             | tools / SaaS            |
| ADOBE TRIAL UPGRADE                              | tools / SaaS            |
| ZENITH TRAVEL                                    | travel                  |
| MORRISON LEGAL LLP                               | professional services   |
| BLUE BOTTLE / RESTAURANTS                        | dining                  |
| USPS POSTAGE                                     | other                   |
| OFFICE SUPPLIES CO                               | other                   |
