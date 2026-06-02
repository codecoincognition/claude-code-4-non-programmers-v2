# ~/work/legal/ — sample contract folder

This folder is the input that `/renewals legal` scans. It holds synthetic,
ready-to-clone sample contracts so you can run the command end-to-end before
you point it at your own real `~/work/legal/`.

## What's here (matches the chapter's output)

| File | Counterparty | Type | Renewal date | Annual value |
|---|---|---|---|---|
| `acme-msa.md` | Acme Corp | MSA (auto-renew) | 2026-11-15 | $84,000 |
| `northwind-sow.md` | Northwind LLC | SOW | 2026-12-08 | $24,000 |
| `globex-msa.md` | Globex Inc. | MSA (auto-renew) | 2027-01-22 | $36,000 |

These are the three rows the chapter's `/renewals legal` run produces,
sorted by days-remaining with Acme (⚠ < 30 days) at the top.

## The Acme renewal-terms PDF

The chapter's output references `~/work/legal/acme-msa-renewal.pdf` — the
formal renewal notice Maya first read in Chapter 0.2. We don't ship a binary
PDF here (a real renewal PDF would be the vendor's own document). The key
facts that file contains are captured in the "Renewal / pricing" section of
`acme-msa.md`: 4.2% pricing increase, 30-day written-notice window. If you
want a real PDF to test PDF parsing, drop any contract PDF into this folder
named `acme-msa-renewal.pdf`.

## Adding noise (optional)

The chapter says Claude found "11 documents, 7 match contract signals." The
three files above are the contracts. The other documents are just normal
folder clutter (meeting notes, a logo, an old invoice) that `/renewals`
correctly ignores because they don't carry contract signals. Add any
non-contract `.md` or `.txt` files here to see the filtering in action.
