# Chapter 11 — Reuben, the bookkeeper · Prompts (verbatim, in order)

Every prompt from the chapter, exactly as printed, in the order it appears.

---

## Setup — copy the sample CSV (command, not a prompt)

```
cp ~/work/companion/ch11-reuben-bookkeeper/data/transactions.csv.sample ~/work/data/transactions.csv
```

---

## Step 1 — Write the deterministic core first

> My transactions for the last 90 days are in ~/work/data/transactions.csv — date, amount, description, the bank's category. For the numbers I don't want AI guessing — I want exact arithmetic I can check by hand: total inflow, total outflow, the monthly grouping, and the balance over time. Build me something that computes those exactly from the CSV every time, with no AI in the math part. Show me sample output.

---

## Step 2 — Author the Reuben agent

> Author the Reuben agent at ~/work/.claude/agents/reuben.md. His job: read the deterministic script's output AND the raw CSV, then categorize transactions (office supplies, software, travel, client revenue, contractor expense, etc.), spot anomalies (any transaction more than 2 standard deviations from the monthly mean for its category), and write a one-page narrative for the month. He NEVER does arithmetic himself — every number in his narrative comes from the deterministic script, quoted verbatim. Let him read files in ~/work/data/ and ~/work/books/, edit only files in ~/work/books/, and run only the one script — reuben-deterministic.sh. Output goes to ~/work/books/pnl-{month}.md.

---

## Step 3 — Run Reuben on a real month

> Run Reuben on April 2026. Show me the deterministic output first, then his narrative built on top of it.

### Step 3 extension — add the Marketing section

> Extend Reuben to add a Marketing section to the monthly P&L. Read the Notion Leads database (the one the Chapter 19 landing page writes to) for rows submitted in the target month, group by utm_source and utm_campaign, count leads per source, and divide the campaign cost (read from ~/work/data/ad-spend-{month}.csv) by lead count to get cost per lead. Same rule as before — the script does the math, Reuben writes the words. Add the section to ~/work/books/pnl-{month}.md after "What changed vs. last month."

---

## Step 4 — Add an end-of-run hook on Reuben

> Set up a hook on Reuben's agent file that fires when he finishes a run. Check if a new month has been completed since the last Reuben run. If yes, confirm ~/work/books/pnl-{month}.md exists and write a one-line note to ~/work/books/filing-log.md. If no month has crossed, do nothing.

(Claude wires this through Reuben's frontmatter as a `Stop` event — converted
to `SubagentStop` when he runs as a subagent — so it fires only when Reuben
finishes, not at the end of every session.)

---

## Step 5 — See the hook with and without a month boundary

> Simulate Reuben's end-of-run hook firing on May 5 with last filing for April (a fresh month — should act). Then simulate it firing on May 5 with last filing for May (no crossing — should do nothing). Walk me through what happens in each case.

---

## Step 6 — Compare Reuben to Iris and Atlas, in writing

> Compare Reuben to Iris and Atlas. Read all three agent files and tell me — in plain English — three structural differences and why each one matters for the kind of work each one does.

---

## When it goes wrong — the recovery prompt

> Reuben said "approximately $14,300" instead of $14,287.43, and the per-category numbers don't sum to the total. Update his system prompt: every number in the narrative MUST be quoted exactly as the deterministic script produced it — to the cent — never rounded, never softened with "approximately" or "about." Per-category breakdowns MUST sum to the deterministic total; if they don't, write a "RECONCILIATION DISCREPANCY: $X.XX" line and refuse to file. Re-run on April and show me the corrected narrative.

---

## Make it yours — five follow-up prompts

**1. Categorization training.**

> Reuben miscategorized 7 transactions last month — I corrected them in the P&L. Update his system prompt to learn from those: add a categorization-rules section he reads at the start of every run, and add my 7 corrections as worked examples.

**2. Quarterly and annual rollups.**

> Add a second hybrid agent — `reuben-quarterly` — that runs at month-end on the third month of each quarter, reads the three monthly P&Ls, and produces a quarterly summary with the same fidelity discipline.

**3. Anomaly-threshold tuning.**

> The 2-sigma anomaly rule has been flagging too much — most of those flags are not actually interesting. Update Reuben to use 2.5 sigma OR an absolute floor of $500 — whichever is more restrictive — for what counts as an anomaly worth narrating.

**4. Receipt-matching.**

> Extend the deterministic script to also read PDFs in `~/work/data/receipts/{month}/` and match them to CSV transactions by date and amount. Reuben flags any transaction without a matching receipt and any receipt without a matching transaction.

**5. The annual tax-filing pre-pack.**

> Every December, run a special Reuben pass that reads all 12 monthly P&Ls and produces a tax-prep summary in the format my accountant wants — categories rolled up to her schedule, anomalies listed separately, source links to every supporting transaction.

---

## Test yourself in 60 seconds (chapter-end)

1. > Run Reuben on ~/work/data/transactions.csv. Show me the deterministic totals first, then the categorized P&L.
2. > Read ~/work/books/filing-log.md and tell me which months have been filed and when.
3. > Explain in one sentence why Reuben's body is split between a script and an agent, and why Iris's body is not.

Stuck?

> audit my Chapter 11 setup against the chapter spec
