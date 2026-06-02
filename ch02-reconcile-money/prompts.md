# Prompts — Chapter 2

Every prompt from the chapter, copy-paste ready. Run from `~/work` with `claude`.

The badge prefix — *"I run a small marketing consulting firm; my finance data is
in `~/work/finance/`; never edit anything outside `~/work/`."* — leads every
prompt. You type it eleven times across Chapters 1 and 2. That friction is what
Chapter 3 (`CLAUDE.md`) fixes.

---

## The five steps

### Step 1 — Describe the files first (don't categorize anything yet)

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/.

Read every CSV in ~/work/finance/. Tell me what's in each file: how many rows, the date range, the columns, what each one represents (bank? Stripe? something else?). Don't categorize anything yet. Just describe.
```

### Step 2 — Reconcile bank credits against Stripe payouts

```
Reconcile the bank file against the Stripe file. Match every Stripe payout to the corresponding bank credit (allow 1-3 business days of slip between the payout date and the bank credit date — that's normal ACH lag). Flag any Stripe payouts that don't show up on the bank side and any bank credits that don't have a Stripe payout match. Write a section in ~/work/finance/2026-Q3-reconciliation.md called "Revenue reconciliation."
```

### Step 3 — Categorize the spend

```
Now categorize the remaining bank charges (the debits, money going out). Buckets: tools/SaaS (Software-as-a-Service — subscription web apps), payroll, infrastructure (AWS/hosting), advertising, travel, dining, professional services, other. Find recurring charges — same vendor, similar amount, monthly cadence — and call them out separately. Add a "Spend breakdown" section to the reconciliation file with totals by bucket and a list of recurring charges with their monthly cadence.
```

### Step 4 — Sharpen yesterday's draft into the canonical leak file

```
Read ~/work/finance/subscription-leaks-draft.md from yesterday. For each of the seven subscriptions, find the matching bank charges in the last 90 days, confirm the actual monthly cost from the bank (the email confirmation may be stale or rounded), and fill in last_charge_date from the most recent bank transaction. Save the canonical version to ~/work/finance/subscription-leaks.md. Same format as the draft: four columns, name | monthly_cost | last_charge_date | cancellation_url. All 7 rows stay; these are exactly the leaks I forgot about, and the bank charges should confirm them all.
```

### Step 5 — Write the executive summary for Dana

```
At the top of ~/work/finance/2026-Q3-reconciliation.md, write a one-paragraph executive summary for Dana — the question was "why is the gap between Stripe revenue ($11.2k) and bank cash ($9.6k) bigger than expected." Use the reconciliation you just did to answer in plain English. Three sentences.
```

---

## When it goes wrong — the double-counted refund

```
In the spend breakdown you just wrote, you have travel as $1,044. I think you double-counted a refund. The Zenith Travel debit on Aug 12 was $844, but there's a credit from Zenith Travel on Aug 19 for $200 that's the partial refund. The net travel was $644. Re-do the categorization treating refunds (credits with the same vendor as a recent debit) as offsets. Add a "Refund verification" sub-step to the methodology so you check this every time.
```

---

## Make it yours — five prompts for tonight

### 1. Receipts versus the corporate card

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read the corporate-card statement (~/work/finance/amex-2026-Q3.csv) and reconcile against my receipts folder (~/work/expenses/2026-Q3/). Match each card charge to a receipt; flag charges with no receipt and receipts with no card charge. Write the report to ~/work/expenses/expense-reconciliation-2026-Q3.md.
```

### 2. Six months of recurring vendors, plotted in prose

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read ~/work/finance/'s last six months of bank exports. For my five biggest recurring vendors, narrate the monthly spend trend. Tell me which ones grew and which ones shrank. Don't draw a chart yet — just narrate the trend in three sentences each.
```

### 3. HubSpot versus Stripe — who converted, who didn't

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read ~/work/customers/hubspot-export.csv and ~/work/customers/stripe-customers.csv. Reconcile on email. Flag (a) HubSpot contacts who became Stripe customers (sales worked), (b) HubSpot contacts who never converted, (c) Stripe customers who aren't in HubSpot (your sales process missed them). Write the report at ~/work/customers/conversion-audit.md.
```

### 4. A Schedule C draft from last year's bank file

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read ~/work/finance/2025-bank-statement.csv (last year). Build a Schedule C draft for the IRS — categorize every business debit by Schedule C bucket. Write the draft at ~/work/finance/2025-schedule-c-draft.md. Note any rows where you're guessing the bucket; I'll review.
```

### 5. The customer most likely to churn

```
I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read every Stripe payout for the last 12 months. Find the customer with the highest lifetime value and the customer with the highest churn risk (large invoice followed by no recent invoices). Write a one-paragraph profile of each.
```

---

## Test yourself in 60 seconds

```
Read ~/work/finance/2026-Q3-reconciliation.md and give me the executive summary in three lines.
```

```
Open ~/work/finance/subscription-leaks.md and confirm it has exactly four columns (name, monthly_cost, last_charge_date, cancellation_url) and seven rows.
```

```
Count how many times in Chapter 1 and Chapter 2 I had to type the badge prefix at the start of a prompt. Tell me the total — that's the friction Chapter 3 fixes.
```

### Stuck?

```
Audit my Chapter 2 setup against the chapter spec.
```
