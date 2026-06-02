# Chapter 4 — every prompt, in order

Copy-paste these in sequence. Prompts you type at the Claude conversation are
marked **[prompt]**. Things you type at the shell or as a slash command are
marked **[type]**. This chapter is the one Part-I exception where you type
slashes yourself.

---

## Step 1 — Let Claude pick which three prompts to promote

**[type]** (start a session in your work folder)

```
cd ~/work && claude
```

**[prompt]**

> Look at my session history for the last 30 days. Find the prompts I keep
> retyping — the ones with the same shape, just different filenames or dates.
> Rank them by frequency. Recommend the three I'd most benefit from turning
> into slash commands. If you can't see my history, ask me to list the ten
> prompts I most remember retyping.

---

## Step 2 — Promote /reconcile (your first slash command)

**[prompt]**

> Turn the reconciliation prompt into a slash command. Save it as
> ~/work/.claude/commands/reconcile.md. The body should run the same thing we
> did in Chapter 2, against the latest CSVs in ~/work/finance/. Include the
> bank-vs-Stripe reconciliation, the spend-bucket categorization, the
> subscription-leaks sharpening, and the report-write to a file named with the
> current month. Show me the file when you're done.

---

## Step 3 — Quit, restart, run /reconcile

**[type]**

```
/exit
```

**[type]**

```
cd ~/work && claude
```

**[type]**

```
/reconcile
```

---

## Step 4 — Promote /triage (the cross-system command)

**[prompt]**

> Same thing for the cross-system triage prompt. Save it as
> ~/work/.claude/commands/triage.md. The body: read my unread Gmail from the
> last 24 hours, my recent Slack DMs, and my Notion mentions. Classify each
> into "needs reply," "needs action by me," "FYI," or "safe to ignore." Don't
> draft replies yet — just the triage. I'll connect Gmail, Slack, and Notion in
> Chapter 5; for now, write the prompt to assume the MCPs aren't ready, and
> instruct Claude to ask me for a digest if no MCPs are available.

---

## Step 5 — Promote /renewals (and meet $ARGUMENTS)

**[prompt]**

> Now the third one — /renewals. But this one needs to take input. Sometimes I
> want to look at contracts in ~/work/legal/, sometimes in
> ~/work/finance/contracts/. Save it as ~/work/.claude/commands/renewals.md and
> make it accept an argument so I can type "/renewals legal" or
> "/renewals finance/contracts" and the subfolder gets substituted in. The
> argument is the path under ~/work/. If I run /renewals with no argument, ask
> me which subfolder I meant — don't silently default.

**[type]** (test it)

```
/exit
```

```
cd ~/work && claude
```

```
/renewals legal
```

---

## Step 6 — The rule, named

**[prompt]**

> Now the rule, in your own words, for the rest of the book: when do I type a
> slash command myself, and when do I just ask in plain English and let you
> pick?

---

## Step 7 — See the menu

**[prompt]**

> Show me the menu of what slash commands can include — I want to see the full
> family before I write more. One row per pattern, with the smallest possible
> example.

---

## When it goes wrong

**[type]** (in a stale session, /reconcile returns "command not found")

```
/reconcile
```

**[prompt]**

> /reconcile says "command not found" and /renewals without an argument doesn't
> ask me — it just defaults to the wrong folder. What's wrong, and how do I make
> /renewals insist on an argument?

(Fix: `/exit` and restart so the new commands load. The whitespace-hardened
`renewals.md` in this repo already includes the "empty OR whitespace-only" fix.)

---

## Make it yours — five follow-ups

**1. Look for two more promotions — but only if they qualify.**

> Look at my session history (or my muscle memory of recent prompts) and
> recommend two more prompts I should turn into slash commands. Apply the
> threshold strictly — if none qualify (typed at least 5 times with stable
> shape), say so. Don't promote prompts I haven't actually run repeatedly.

**2. Add frontmatter for /help.**

> Add YAML frontmatter to my three commands so each shows a one-line description
> when I type /help. Pull each description from the first line of the command
> body. Don't add anything else, just the description field.

(See `extras/commands-with-frontmatter/` for the result.)

**3. Build /reconcile-quarter.**

> My /reconcile command writes the report file with the current month in the
> name. Once a quarter, I want a roll-up across the three months. Build a
> /reconcile-quarter command (no $ARGUMENTS — just the most recent closed
> quarter) that reads the three monthly reports and produces a quarterly
> summary.

(See `work/.claude/commands/reconcile-quarter.md`.)

**4. Build /renewals all.**

> Make a /renewals all shortcut that runs /renewals legal and
> /renewals finance/contracts and merges the output. Show me the file before
> saving.

(See `work/.claude/commands/renewals-all.md`.)

**5. Audit your commands by usage.**

> Show me a list of all my slash commands ranked by how often I'm probably
> running them. If there's a command I haven't called in three weeks, suggest I
> delete it.

---

## Test yourself in 60 seconds

1. Run my reconcile command on the latest CSVs in ~/work/finance/ and produce a
   P&L narrative.
2. Run my triage command and tell me what's on my plate this week, grouped by
   source.
3. List every slash command in ~/work/.claude/commands/ ranked by how often I'm
   probably running them. Suggest deleting any I haven't called in three weeks.

Stuck? Run "audit my Chapter 4 setup against the chapter spec" — Claude reads
your files and tells you what's missing.
