# 2026-Q3 reconciliation

## Executive summary  (for Dana)

Of $11.2k in Stripe gross revenue, $1.2k (Bolt Inc., 2026-08-14) appears in Stripe as paid out but never landed on the bank side — almost certainly an ACH return; investigating. Another $1.8k (Acme Corp, 2026-09-29) lands as a Q4 credit on 2026-10-02 — timing across the quarter boundary, not lost. The remaining $8.2k matched cleanly within the 1-3 business day ACH window. Net of Stripe fees (~$246 on the matched portion, about 3%), that's roughly $7.95k in this-quarter cash from Stripe; the rest of the bank's $9.6k is operating cash from elsewhere. The gap you noticed is the missing Bolt payout plus the Acme timing slip, not unexpected spend.

## Revenue reconciliation

41 of 43 Stripe payouts ($8,200 of $11,200 gross) reconcile cleanly against bank credits within the standard 1-3 business day ACH window.

One payout ($1,200, 2026-08-14, customer: Bolt Inc.) does not appear on the bank side as of 2026-09-30. The most common cause is an ACH return — the customer's bank reversed the transfer days after Stripe recorded it as paid out. Recommended: check Stripe's dashboard for the dispute / failure status on that payout, then chase the customer or refund the corresponding invoice.

A second payout ($1,800, 2026-09-29, customer: Acme Corp) shows up as a bank credit on 2026-10-02. That's the quarter boundary — it's Q4 cash, not Q3. Not an anomaly; just a timing note.

## Spend breakdown

From bank debits for 2026-Q3:

| bucket                | quarter total | monthly average | note                                   |
|-----------------------|---------------|-----------------|----------------------------------------|
| tools / SaaS          | $4,281        | $1,427/mo       | matches Dana's "$1,400"                |
| payroll               | $23,400       | $7,800/mo       | two employees, 1st & 15th              |
| infrastructure        | $1,026        | $342/mo         | AWS / hosting                          |
| advertising           | $0            | —               | none this quarter                      |
| travel                | $844          | —               | one trip, Zenith Travel, Aug           |
| dining                | $234          | —               |                                        |
| professional services | $1,200        | —               | one law firm (Morrison Legal LLP)      |
| other                 | $89           | —               | postage, office supplies               |
| **Total debits**      | **$31,074**   |                 | of which $1,427/mo are recurring SaaS  |

### Recurring SaaS charges (23 detected, top 8 by spend)

| vendor                | monthly cost | charged on |
|-----------------------|--------------|------------|
| Adobe Creative Cloud  | $54.99       | 8th        |
| Notion (team plan)    | $40.00       | 11th       |
| Google Workspace      | $36.00       | 1st        |
| Canva Teams           | $29.99       | 13th       |
| Grammarly Business    | $25.00       | 24th       |
| Vercel Pro            | $20.00       | 7th        |
| 1Password Teams       | $19.95       | 3rd        |
| Spotify family add-on | $16.05       | 18th       |
| ... (15 more)         |              |            |

> Recurring detection: rows are grouped by a fuzzy match of the vendor
> description, then the calendar deltas between charges from the same group are
> measured. Three charges within a 28-32 day window of each other, with the
> dollar amount within a few cents of identical, are flagged as a monthly
> subscription. 89-92 day deltas = quarterly; 364-366 days = annual.

## Methodology

1. **Describe pass.** Both CSVs introspected for row count, date range, columns,
   and meaning before any categorization.
2. **Revenue reconciliation.** Bank credits joined to Stripe payouts on
   (date ± 3 business days) and (amount within $1). Unmatched rows flagged.
3. **Spend categorization.** Bank debits bucketed into tools/SaaS, payroll,
   infrastructure, advertising, travel, dining, professional services, other.
4. **Refund verification.** Each non-Stripe credit is checked against debits from
   the same vendor in the previous 30 days; matched pairs are treated as net
   spend (offset), not two separate events. (Added after the Oct double-count.)
5. **Recurring detection.** Vendor-grouped charges with consistent cadence and
   amount flagged as subscriptions.
