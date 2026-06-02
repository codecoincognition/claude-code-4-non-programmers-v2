# /renewals all

Run the renewal scan across BOTH contract locations and merge the
output into one view. This is a shortcut that composes /renewals.

Step 1 — scan ~/work/legal/ for contracts (client MSAs and SOWs).
Step 2 — scan ~/work/finance/contracts/ for contracts (vendor agreements).

Apply the same contract-detection and extraction rules as /renewals:
A contract is any PDF, DOCX, or markdown file with at least one of:
  - "agreement," "MSA," "SOW," "contract" in the filename
  - "renewal date," "term," "auto-renew" in the body

For each contract extract: counterparty, effective date, renewal date
(next auto-renewal if auto-renew), days remaining (today = $TODAY),
dollar value.

Merge both location's results into ONE table, sorted by days-remaining
ascending. Add a "Source" column showing legal vs finance/contracts.
  - ⚠ marker on anything < 30 days, pinned to the top.
  - Include anything < 90 days in the main table.
  - Skip anything > 365 days.

End with a one-line recommendation: across both locations, which single
contract warrants action this week.
