# Chapter 26 — prompts, verbatim and in order

Every prompt the chapter has you give Claude during the Sunday-night
governance hour, in the order they appear. Eight steps, eight prompts, then
five *Make it yours* variants and the "when it goes wrong" recovery prompt.

---

## Step 1 — Inventory the .claude/ folder

```
It's Sunday night. Walk me through my .claude/ folder. List every CLAUDE.md,
every command, every agent, every skill, every hook. For each one, tell me
when it last did something useful.
```

Read the output the way you'd read a small shop's payroll. Most names will be
obvious — they did work this week. The ones that didn't are the conversation.

---

## Step 2 — Read this week's escalation, cancellation, and build logs

```
Three things to check this week:
(1) pull this week's ~/work/watchdog/escalations.log, group entries by monitor,
    tell me how many were escalate, how many notify, how many log_only, and
    surface anything that should make me change a tier rubric;
(2) pull this week's ~/work/finance/cancellations/ entries — anything new closed;
(3) confirm the dashboard build cron ran every night this week with exit code 0.
```

The artifact you're looking for in the escalation table: any `escalate` line
(skim these first), then any pattern in the `notify` lines that points at a
false-positive — a tier rubric that needs tightening.

---

## Step 3 — Ask Claude about the least-active artifact

Substitute the agent name from your Step 1 inventory. The chapter's example is
`research-helper`, eight weeks idle:

```
Tell me about research-helper — the subagent I haven't invoked in 8 weeks.
Should I keep it, retire it, or rebuild it for the work I'm actually doing now?
```

Claude reads the agent file, recent prompt patterns, and the rest of the
roster. It returns one of three recommendations: keep, retire, or rebuild.

---

## Step 4 — Retire the agent (archive, don't delete)

```
Retire research-helper. Move the file to ~/work/.claude/retired/research-helper.md
(don't delete; archive). Add a one-line entry to my governance log explaining why.
```

The file moves to `~/work/.claude/retired/`. The log gets one line, dated, with
the reason. Six months from now, when you wonder *"what happened to
research-helper,"* the log answers in one breath.

---

## Step 5 — Tighten one rubric

Substitute the monitor name from your Step 2 false-positive review. The
chapter's example is `calendar-monitor` (a meeting that was rescheduled before
the alert fired):

```
Read calendar-monitor's tier rubric. Tighten the notify threshold so meetings
rescheduled-before-alert don't fire. Show me the diff before saving.
```

Read the diff. Approve. The fix is usually two or three lines, not a redesign.
The discipline is *noticing the false positive in the log*, not engineering a
perfect rubric on day one.

---

## Step 6 — Audit one skill against recent artifacts

Substitute the skill name from your Step 1 inventory. The chapter's example is
`your-tone.md`:

```
Look at your-tone.md. Pull three pieces of writing I made Claude produce in
the past 14 days. Tell me whether the skill's rules still match the voice I'm
actually publishing — or whether the skill needs an update.
```

Skills drift in two directions: either the skill is stricter than your actual
practice (you've started breaking a rule consistently and it reads well), or
your practice is stricter than the skill (you've started avoiding a phrasing
the skill still allows). Both are drift. The audit catches both.

---

## Step 7 — Write the checklist for next week

```
You've just walked me through one governance hour. Write the checklist for it
— five items, one line each — that I can keep at ~/work/governance/sunday-checklist.md
and reuse next week.
```

The output is the artifact this folder ships as
[`work/governance/sunday-checklist.md`](./work/governance/sunday-checklist.md).

---

## Step 8 — Read the morning forward, then close the laptop

```
Tell me what to expect tomorrow morning at 6:45 AM, given everything in my
.claude/ is now updated for the week.
```

The last prompt of the chapter, and of the book. Read the reply. Close the
laptop. The mesh runs without you.

---

## When it goes wrong — the catch-up audit

For when the hour has been skipped for three months and the folder has
overgrown:

```
My .claude/ has overgrown. Run a full governance audit — list every artifact,
score each one on a 0-10 of last-30-day usefulness, and flag the bottom third
for a fire / rebuild / keep decision. Then walk me through them one at a time.
```

The fix takes an hour and a half — half again the regular weekly hour.
Skipping the discipline for a month feels like nothing. Skipping it for six
months means starting over.

---

## Make it yours — 5 variants

### 1. Run the hour for me when I'm tired

```
It's Sunday night and I'm tired. Run the governance hour for me — go through
all five steps in sequence and surface only the decisions I have to make.
```

### 2. Heat-map the staff

```
Tell me which agent in my .claude/ is getting invoked most often and which is
getting invoked least. For the most-invoked, propose one improvement. For the
least-invoked, ask me the fire / keep / rebuild question.
```

### 3. Tell me what kind of operator I've become

```
Read my entire .claude/ and tell me, in one paragraph, what kind of operator
I've become — what kinds of work I've delegated, what I've kept for myself,
and where the next chapter of my staff might want to grow.
```

### 4. Apply the Ch 3 litmus test to CLAUDE.md

```
Look at my CLAUDE.md and apply the litmus test from Ch 3 — for each rule,
would removing it cause Claude to do the wrong thing? Strip the rules that
fail the test.
```

### 5. Tell me what I'd lose if I deleted .claude/ tomorrow

```
Tell me what I would lose, in concrete terms, if I deleted my .claude/ folder
tomorrow. Walk me through it as if you were the cost — what re-emerges as my
problem, what disappears for good.
```
