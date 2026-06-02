# ~/work/expenses/2026-Q3/  — receipts folder (make-it-yours prompt 1)

Make-it-yours prompt 1 reconciles `~/work/finance/amex-2026-Q3.csv` against the
receipts you keep in this folder. Real receipts are your own private files (PDF
scans, photos, or forwarded email confirmations), so the companion repo does not
ship them — it ships this note plus two tiny stand-in receipts so you can run the
pattern end to end before pointing it at your own.

## What a receipt looks like to Claude

Each receipt is just a file in this folder. It can be a PDF, an image, or a plain
text/markdown confirmation. Claude reads the vendor, date, and amount out of each
and matches them to a card charge in `amex-2026-Q3.csv`. The reconciliation flags:

- card charges with **no matching receipt** (you owe a receipt)
- receipts with **no matching card charge** (paid another way, or a duplicate)

## Stand-in samples in this folder

- `receipt-delta-2026-07-08.txt`   — matches the $412.30 Delta charge
- `receipt-hilton-2026-07-08.txt`  — matches the $288.00 Hilton charge

The other eight card charges in `amex-2026-Q3.csv` have no receipt here on
purpose — that is exactly the "missing receipt" list the reconciliation should
surface. Drop your own receipts in to fill them.
