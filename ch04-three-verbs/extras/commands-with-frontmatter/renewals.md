---
description: Scan a contracts subfolder for upcoming renewal dates (takes a folder arg)
---

# /renewals $ARGUMENTS

If $ARGUMENTS is empty OR contains only whitespace, stop and ask:
  "Which subfolder of ~/work/ should I scan? (e.g., legal,
   finance/contracts)"
Wait for an answer before continuing. Do not proceed under any
circumstances with an empty or whitespace-only argument.

Otherwise, scan ~/work/$ARGUMENTS/ for contracts.
A contract is any PDF, DOCX, or markdown file with at least
one of these signals:
  - "agreement," "MSA," "SOW," "contract" in the filename
  - "renewal date," "term," "auto-renew" in the body

For each contract, extract:
  - Counterparty (the other party's name)
  - Effective date
  - Renewal date (next one — if auto-renew, the date the next
    auto-renewal fires)
  - Days remaining until renewal (today = $TODAY)
  - Dollar value (annual or total, whichever is in the doc)

Output a table sorted by days-remaining, ascending.
Surface anything < 30 days at the top with a ⚠ marker.
Surface anything < 90 days in the main table.
Skip anything > 365 days.

End with a one-line recommendation: which contract, if any,
warrants action this week.
