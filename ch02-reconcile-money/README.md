# Chapter 2 — Reconcile your money in 10 minutes

Companion repo for Chapter 2 of *Claude Code for Non-Programmers*.

Two CSV files. Ten minutes. A categorized P&L narrative Maya hands to her
co-founder, plus the canonical seven-row leak file Chapter 20 reads to cancel
each subscription. None of it happens in a chat window — it all happens where
the files live.

**You do not need to clone this to do the chapter.** Everything you need is in
the chapter text. This repo is here if you'd rather see the finished artifacts
and run the pattern end to end against shipped sample data before pointing it at
your own bank export.

---

## What's in here

```
ch02-reconcile-money/
├── README.md                         ← you are here
├── prompts.md                        ← every prompt from the chapter, copy-paste ready
├── fixtures/
│   └── README.md                     ← how the private-data inputs work (Gmail/HubSpot/Stripe)
└── work/                             ← this is your ~/work/ as it looks after Chapter 2
    ├── .claude/
    │   └── settings.local.json       ← the ~/work/ fence (Read/Write/Edit scoped to ~/work/**)
    ├── finance/
    │   ├── bank-statement-2026-Q3.csv        INPUT  — 847 rows, one quarter, DEBIT/CREDIT
    │   ├── stripe-payouts-2026-Q3.csv        INPUT  — 43 payouts, gross-of-fees
    │   ├── subscription-leaks-draft.md       FROM CH1 — email-derived, not yet bank-confirmed
    │   ├── 2026-Q3-reconciliation.md         OUTPUT — exec summary + revenue recon + spend breakdown
    │   ├── subscription-leaks.md             OUTPUT — CANONICAL, 4 cols / 7 rows (Ch 20 reads this)
    │   ├── vendor-categories.md              the vendor-name-drift fix (read me first each run)
    │   ├── amex-2026-Q3.csv                  make-it-yours prompt 1 (corporate card)
    │   └── 2025-bank-statement.csv           make-it-yours prompt 4 (Schedule C draft)
    ├── customers/
    │   ├── hubspot-export.csv                make-it-yours prompt 3 (HubSpot side)
    │   └── stripe-customers.csv              make-it-yours prompt 3 (Stripe side)
    └── expenses/
        └── 2026-Q3/
            ├── README.md                     what a receipts folder looks like to Claude
            ├── receipt-delta-2026-07-08.txt  stand-in receipt (matches $412.30 Delta charge)
            └── receipt-hilton-2026-07-08.txt stand-in receipt (matches $288.00 Hilton charge)
```

---

## How to run it

1. Copy `work/` to your home directory so the paths in the chapter resolve:

   ```
   cp -R work/ ~/work-ch02-demo      # or merge into your real ~/work/
   ```

   The chapter writes everything under `~/work/finance/`. If you'd rather not
   touch your real `~/work/`, run against a copy and read the paths accordingly.

2. From the folder one level above `finance/`, start Claude:

   ```
   cd ~/work && claude
   ```

3. Paste the five prompts from `prompts.md` in order (Steps 1–5). They will
   reproduce `2026-Q3-reconciliation.md` and `subscription-leaks.md` — the two
   shipped outputs are what a correct run looks like.

---

## The canonical leak file — do not change its shape

`work/finance/subscription-leaks.md` is the file **Chapter 20** opens to cancel
each subscription through browser automation. It expects this exact shape:

- four columns: `name | monthly_cost | last_charge_date | cancellation_url`
- seven rows
- total: **$84.00/mo ≈ $1,008/yr** (this is the number Chapter 20's
  "the book pays for itself thirty-three times over" line runs off)

Don't rename it, don't change the columns, don't drop rows.

---

## Data is internally consistent (so the recon resolves the way the chapter says)

- The bank file has exactly **41** `STRIPE PAYOUT` credits → "41 of 43 payouts match."
- **Bolt Inc.** ($1,200, 2026-08-14) is in the Stripe export but **absent** from
  the bank file → the ACH-return anomaly.
- **Acme Corp** ($1,800, 2026-09-29) is in the Stripe export but **absent** from
  the Q3 bank file → the quarter-boundary timing slip (lands Q4).

---

## Privacy note (carried from the chapter)

A bank CSV is among the most sensitive files you own. This entire chapter runs
locally — Claude reads the file from your disk; nothing is uploaded beyond the
prompt-and-response Claude Code already sends to Anthropic to answer. If you are
uncomfortable with even that, run the chapter against the sample bank export
shipped here and trust the pattern. See `fixtures/README.md` for how the
private-app inputs (Gmail receipts, HubSpot, Stripe) are handled.
