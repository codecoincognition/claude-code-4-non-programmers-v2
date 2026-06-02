# Chapter 1 prompts — copy-paste, in order

Every prompt below is reproduced verbatim from the chapter. The first line of the
Step 1 / Make-it-yours prompts is the **badge** — the one-line "who I am, where the
fences are" preamble you type at the start of each session until Chapter 3, where
CLAUDE.md takes it over permanently.

Open Claude in your home folder first:

    cd ~ && claude

---

## Step 1 — Read the folder, write the report, pull the subscriptions

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Today is the one exception: ~/Downloads/ is also in scope for this cleanup.

    Read everything in ~/Downloads. Don't move or delete anything. Do three things in one pass:

    1. Write a categorized report to ~/Downloads/to-act-on.md. Include: types and counts of files, anything flagged as a duplicate (use byte-hash, not just filenames), anything that looks like an action — contracts, invoices, subscription confirmations.

    2. Find the subscription confirmation PDFs and also write ~/work/finance/subscription-leaks-draft.md — a four-column markdown table: name | monthly_cost | last_charge_date | cancellation_url. Pull dollar amounts and cancellation links from the confirmation bodies. For last_charge_date, use the email confirmation date — Chapter 2 will sharpen it against the bank.

    3. In the report, list the byte-identical duplicates separately — I'll move them in the next prompt.

---

## Step 2 — Move the duplicates (describe-then-move)

    Same scope as Step 1 — ~/Downloads/ is in scope today. Find the duplicates. Move them, don't delete, to ~/Downloads/_duplicates/. Show me the plan first. Use byte-hash to confirm two files are identical — I have three contract PDFs that share a name but aren't the same file.

After you read and approve the move plan:

    Go.

---

## Step 3 — Open the three contracts that share a name

    Open the three MSA_final_FINAL_v3.pdf files — the ones that look duplicate by name but aren't. For each, tell me the signing parties, the effective date, the renewal date, and which one is the most urgent.

---

## When it goes wrong — re-classify a misjudged file

    7f8a9b2c-2024-q3.pdf isn't junk — it's the Q3 contract from my CFO. Open it, identify the signing parties, the effective date, and what it covers, and re-classify it. Then look back at the rest of the junk section and check whether any other UUID-named files are similarly misclassified.

---

## Make it yours — five prompts for tonight

### 1. The Desktop you've been ignoring

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read everything in ~/Desktop. Categorize by 'looks like work,' 'screenshots,' 'random downloads,' and 'images I should keep.' Write the report to ~/Desktop/to-act-on.md. Don't move anything.

### 2. Everything related to one vendor before a renewal call

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Find every PDF in ~/Documents/ that mentions Acme Corp. List them with dates, paths, and one sentence each on what the document appears to be. I want to see everything related to that vendor in one place before our renewal call on Thursday.

### 3. Tax-prep receipts, sorted into IRS buckets

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/. Read every receipt PDF in ~/Documents/2024-tax-prep/. Group by IRS Schedule C bucket: advertising, office expense, software, travel, meals, professional services. Produce a CSV at ~/work/2024-tax-summary.csv.

### 4. 891 screenshots, sorted by app of origin

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/ (today, ~/Downloads/ is also in scope). Read every screenshot-looking PNG in ~/Downloads/ from the last 90 days. Group by what app produced it — Slack, browser, OS — using the filename patterns and any visible UI chrome. Don't move anything; show me the categorization first. I'll pick a scheme and you can run the move plan after.

### 5. Photos from a trip, sorted by location

    I run a small marketing consulting firm; my finance data is in ~/work/finance/; never edit anything outside ~/work/ (today, ~/Pictures/ is also in scope). Look at every photo in ~/Pictures/2024/ from March. Group by GPS location if the EXIF data has coordinates; otherwise group by date. Write a list with file paths and dates to ~/work/photos-march-2024.md. Don't move anything.

---

## Test yourself in 60 seconds

    Open ~/Downloads/to-act-on.md and tell me the two things in it I should act on this week.

    Read ~/work/finance/subscription-leaks-draft.md back to me and tell me the total monthly cost across the seven rows.

    Run a describe-only pass on ~/Desktop. Don't move anything. Show me the categorization first.
