---
description: Reconcile a bank export against my ledger and flag mismatches.
---

Reconcile the most recent bank export in `finance/` against my ledger.

1. Find the newest CSV in `finance/` (the bank export). Tell me which file you picked.
2. Match each bank line to a ledger entry by date + amount.
3. Produce three lists: matched, in-bank-not-in-ledger, in-ledger-not-in-bank.
4. Write the reconciliation to `finance/reconcile-{today's date}.md` and give me the path and a one-line summary (e.g. "27 matched, 2 unexplained").
5. Do not change my ledger. Reconciliation is read-and-report only.
