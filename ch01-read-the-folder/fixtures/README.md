# Fixtures — what Chapter 1 reads (and why we don't ship it)

Chapter 1 points Claude at **your own `~/Downloads/`** — eleven months of real
receipts, contracts, and screenshots. We deliberately do **not** ship a fake
1,400-file Downloads folder, because the whole point of the chapter is reading
*your* files. Instead, this folder documents the shape of the inputs so you can
recognize them, and gives you a tiny synthetic sample if you want to dry-run the
prompts before pointing them at real data.

## What the chapter actually reads

| Input (in the chapter) | Format | Where it comes from |
|---|---|---|
| ~1,400 files in `~/Downloads/` | mixed: `.pdf`, `.png`, `.docx`, `.csv`, `.xlsx`, `.zip` | Your own download history |
| 7 subscription confirmation PDFs | `.pdf` with a text layer (selectable text) | "Welcome to Hulu / DashPass / ..." emails you saved as PDF |
| 3 `MSA_final_FINAL_v3*.pdf` contracts | `.pdf` with a text layer | Signed via an e-sign workflow that names every file the same |
| 47 byte-identical duplicates | any | Files re-downloaded / copied — same content, different path |

Two read-tool facts worth internalizing:

- **Byte-hash, not filename.** A duplicate is two files with the *same content
  hash*, not the same name. The three MSA files share a name but have different
  bytes — they are three different vendors, not duplicates.
- **Text layer required.** Claude reads PDFs that have selectable text. A scanned
  or photographed PDF is a pure image; ask Claude to "run OCR on it and try again."

## Tiny synthetic sample (safe to use)

`sample-downloads/` contains a handful of harmless stand-in files so you can run
the Step 1 prompt against a directory you control before aiming it at real data:

- `sample-downloads/welcome-to-hulu.txt` — a stand-in subscription confirmation
- `sample-downloads/welcome-to-doordash-dashpass.txt` — another one
- `sample-downloads/invoice-2025-Q3.txt` — a stand-in invoice
- `sample-downloads/invoice-2025-Q3-copy.txt` — a byte-identical duplicate of the above

To dry-run: copy `sample-downloads/` somewhere, point the Step 1 prompt at that
path instead of `~/Downloads/`, and watch the describe pass categorize it and
flag the duplicate. The synthetic files are `.txt` (not `.pdf`) only so they
stay human-readable in this repo; the prompt grammar is identical.
