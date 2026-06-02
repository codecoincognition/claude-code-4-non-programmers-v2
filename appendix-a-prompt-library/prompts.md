# Appendix A — Prompt Library

Thirty cross-system jobs from the book, organized as a working operator's catalog.
Each entry names **what crosses what**, the **artifact** it produces, the **prompt
grammar** (one representative phrasing), and the **chapter** that taught the pattern.

These are not chat-shaped prompts. Each one crosses two or more systems — Gmail and
Notion, the filesystem and a scheduled job, an MCP and a named subagent, the browser
and the journal. Strip the agent names (Iris, Reuben, etc.) if your staff has
different ones; the shape is what matters.

**Placeholder convention:** `[ALL-CAPS-WITH-DASHES]` marks a slot you fill in.
`{date}`, `{week}`, `{month}`, `{quarter}` are auto-filled date stamps.
All jobs assume you are inside your `~/work/` folder in a `claude` session.

---

## Daily-driver jobs (8)

The eight jobs you run from a fresh `claude` session most mornings.

### 1 — Morning Iris check
- **Crosses:** Gmail MCP + Notion (Iris's drafts pages) + named subagent `iris`.
- **Artifact:** Iris's draft queue summary → `~/work/journal/iris-{date}.md`.
- **Taught in:** Ch 9.

> Show me what Iris landed overnight: what's in "sent," what's still in "draft
> awaiting my review," what got escalated. For each draft, one sentence on why she
> didn't auto-send. Don't open the inbox yet — just the queue.

### 2 — Newsroom standup
- **Crosses:** Four newsroom agents (editor, researcher, fact-checker, headline) +
  their shared task file `~/work/newsroom/board.md`.
- **Artifact:** A status table appended to `~/work/journal/standup-{date}.md`.
- **Taught in:** Ch 15.

> What is each newsroom agent working on right now? For each one: current task, last
> completed artifact, anything blocking. If two agents are working on the same input,
> flag the duplicate.

### 3 — Reuben's reconciliation
- **Crosses:** Bookkeeper subagent (Reuben) + bank-CSV folder + Stripe MCP
  (read-only) + Notion finance database.
- **Artifact:** P&L delta vs. last week → `~/work/finance/weekly/{date}.md`. Flagged
  transactions appended to a Notion page.
- **Taught in:** Ch 11.

> Run Reuben. File the P&L delta vs. last week. Flag anything over $200 that doesn't
> match a known category, and anything that matches a category but sits more than two
> standard deviations from that category's last 12 weeks. Don't auto-categorize the
> flags — list them.

### 4 — Scheduled-job audit
- **Crosses:** Scheduled-jobs registry + log folder `~/.claude/logs/jobs/` + the cron
  interpreter.
- **Artifact:** A status table → `~/work/journal/jobs-{date}.md` (name, last-fired,
  next-fires, last exit code).
- **Taught in:** Ch 7.

> List every scheduled job: name, when it last fired, when it next fires, last exit
> code. Anything that hasn't fired in its expected window, surface to the top.
> Anything that exited non-zero, show me the last 20 lines of its log.

### 5 — Weekly leads digest
- **Crosses:** Notion Leads database + campaign-cost CSV `~/work/data/ad-spend-{month}.csv`
  + the `your-tone.md` skill.
- **Artifact:** A one-page digest → `~/work/marketing/leads-digest-{week}.md`.
- **Taught in:** Ch 19.

> Pull last 7 days of rows from the Notion Leads DB. Group by utm_source then
> utm_campaign. Compute cost per lead from the campaign-cost CSV. Write the digest in
> my voice — lead with the deltas vs. last week, then the source breakdown, then the
> top three converting CTAs. File at `~/work/marketing/leads-digest-{week}.md`.

### 6 — Plan-mode dry run
- **Crosses:** Plain-English task description + the file system Claude is about to
  touch + plan mode.
- **Artifact:** A numbered execution plan, on screen only, before any tool runs.
- **Taught in:** Ch 8.

> Plan-mode the next thing on my todo: [TASK]. Don't execute. Walk it as a numbered
> list — each step, what it touches, what could go wrong. I'll approve or redirect
> before you start.

### 7 — Watchdog mesh status
- **Crosses:** Four watchdog monitors + orchestrator agent + shared event log.
- **Artifact:** A 24-hour anomaly summary → `~/work/journal/watchdog-{date}.md`.
- **Taught in:** Ch 17.

> Ask the watchdog mesh what it noticed in the last 24 hours that I should care about.
> Filter: things that crossed a threshold, things that stopped firing, things that
> fired more than usual. Skip the routine.

### 8 — End-of-day shutdown
- **Crosses:** SessionEnd hook + journal folder + next morning's scheduled brief inputs.
- **Artifact:** `~/work/journal/{date}-eod.md` plus an updated input list at
  `~/work/journal/_brief-inputs.md`.
- **Taught in:** Ch 7.

> Summarize the day. File SessionEnd notes to `~/work/journal/`. Queue tomorrow's
> morning-brief inputs (any specific files or topics I want pulled). Tell me one thing
> I said earlier this week that I should follow up on next week.

---

## Agent-authoring jobs (10)

Jobs that *build* things. Each produces a file in `.claude/`.

### 9 — New subagent scaffold
- **Crosses:** An existing agent file (Iris) as template + new agent's permission
  scope + a path under `.claude/agents/`.
- **Artifact:** `.claude/agents/{NAME}.md`.
- **Taught in:** Ch 6.

> Read `.claude/agents/iris.md` for the shape, then scaffold `.claude/agents/[NAME].md`
> for [ROLE]. Permissions: [SCOPE]. The agent should never [FORBIDDEN ACTION]. Return
> only the artifact, never the raw working data. Match Iris's structure.

### 10 — Refactor a drifting agent
- **Crosses:** The agent's last 10 outputs (read as files) + the agent file + the
  original tone-of-voice skill.
- **Artifact:** A diff of the agent file, plus a one-paragraph diagnosis appended to
  the agent's changelog.
- **Taught in:** Ch 9.

> Iris's drafts are getting too formal lately. Read the last 10 outputs in
> `~/work/iris/sent/`. Find the drift — specific patterns, not vibes. Propose a
> one-paragraph addition to her agent file that pulls her back. Don't write the
> addition yet; show me the diagnosis first.

### 11 — Author a new skill
- **Crosses:** An existing skill file (the tone-of-voice skill) as template + the
  trigger condition + the skills folder.
- **Artifact:** `.claude/skills/{NAME}.md`.
- **Taught in:** Ch 14.

> Write a skill at `.claude/skills/[NAME].md` for [TASK]. Read `.claude/skills/your-tone.md`
> for the shape. The trigger should fire when [SITUATION]. Keep it under 30 lines.

### 12 — Draft a hook from a wish
- **Crosses:** The hook event menu + Slack MCP + the settings.json file.
- **Artifact:** A diff of `~/work/.claude/settings.json` plus the hook script under
  `~/work/scripts/`.
- **Taught in:** Ch 7.

> Whenever Claude finishes a task that took longer than five minutes, ping Slack on
> `#me`. Pick the right hook event, draft the JSON for `~/work/.claude/settings.json`,
> explain in one sentence why you picked that event over the others. Don't apply yet —
> show me the diff.

### 13 — Draft an MCP tool
- **Crosses:** An existing MCP server's source folder + the new tool spec + a smoke test.
- **Artifact:** A new tool function in `~/work/mcp-servers/personal-data/`, plus a test
  entry, plus one console run of the smoke test.
- **Taught in:** Ch 13.

> Add a tool called [NAME] to my custom MCP at `~/work/mcp-servers/personal-data/`. It
> takes [INPUTS] and returns [OUTPUT]. Pattern-match the existing tools in the same
> server. Add a smoke test to the test file. Run it once and show me the output.

### 14 — Author the verify script
- **Crosses:** The agent file + the watchdog's nightly runner + a known-good test input.
- **Artifact:** `run-and-verify.sh` next to the agent file.
- **Taught in:** Ch 17.

> Write `run-and-verify.sh` for the agent in `.claude/agents/[NAME].md`. Minimum: a
> smoke test the watchdog can run nightly that exits 0 if the agent still works and
> non-zero with a useful message if it doesn't. Don't make it perfect — make it
> informative.

### 15 — Promote a one-off into a skill
- **Crosses:** The session transcript + the pattern in the last three prompts + the
  skills folder.
- **Artifact:** `.claude/skills/{NAME}.md`.
- **Taught in:** Ch 14.

> That thing we just did — turn it into a skill at `.claude/skills/[NAME].md`. The
> trigger is [SITUATION]. The instructions are exactly what you and I just worked
> through, written as steps, not paragraphs.

### 16 — A/B test winner readout
- **Crosses:** PostHog events (the `headline_variant` super-property) + the Notion
  Leads database (conversion rows) + a stats helper that computes confidence intervals.
- **Artifact:** A one-paragraph readout → `~/work/marketing/ab-tests/{date}.md`.
- **Taught in:** Ch 19.

> Read PostHog events for the last 14 days, split by `headline_variant` super-property.
> Join against the Notion Leads DB to compute conversion rate per variant. Compute the
> 95% confidence interval on the delta. If both variants have at least 500 page views
> and the CI excludes zero, declare a winner. Otherwise, keep running. Write the
> one-paragraph readout.

### 17 — Build a watchdog for an agent
- **Crosses:** The agent's run-and-verify script + the watchdog mesh's monitor folder +
  a scheduled job.
- **Artifact:** A new monitor under `.claude/agents/watchdog/`, plus a cron entry, plus
  a Slack ping configured.
- **Taught in:** Ch 17.

> Build me a watchdog that pings me if [AGENT] hasn't run in 48h, or if its last run
> had a non-zero exit, or if its output is empty when it shouldn't be. Use the same
> pattern as the bookkeeper-watchdog in `.claude/agents/`. Cron: daily at 6 PM.

### 18 — Re-prompt with a counterexample
- **Crosses:** The wrong output (pasted) + the right output (pasted) + the agent file.
- **Artifact:** A diff of the agent file with the counterexample inlined.
- **Taught in:** Ch 6.

> Here's an output the agent got wrong: [PASTE]. Here's what I wanted instead: [PASTE].
> Update the agent prompt so it gets this case right next time. Add the counterexample
> inline in the agent file, not as a separate doc.

---

## Debugging jobs (6)

The Karpathy rule sits underneath all six: *paste what you saw, ask what broke*.

### 19 — Paste-the-error (universal)
- **Crosses:** The full error text + the file the error names + a diagnostic prompt.
- **Artifact:** A diagnosis on screen plus, if the fix is small, a diff of the named file.
- **Taught in:** Appendix E.

> [PASTE FULL ERROR — every line, including the last]. What broke and what's the
> smallest fix? Don't rewrite the script — diagnose first, then propose the minimum
> change.

### 20 — Hook hang diagnosis
- **Crosses:** The hook script + the hook event log + a direct shell run of the same
  command.
- **Artifact:** A trace showing where the command blocks, plus a proposed timeout to
  add to the hook JSON.
- **Taught in:** Appendix E.

> My SessionStart hook is hanging. Here's the hook command: [PASTE]. Test it directly
> outside the hook context. Tell me where it blocks, and propose a timeout I can add
> without breaking the hook's job.

### 21 — MCP returning nulls
- **Crosses:** The MCP server log + a smoke test of one tool + the keychain auth entry.
- **Artifact:** A diagnosis naming whether it's auth expiry, schema drift, or upstream
  API change, plus the smoke-test output.
- **Taught in:** Appendix E.

> My [MCP] is returning null where it used to return data. Read the server config at
> [PATH]. Run a smoke test against one known-good query. Tell me whether it's auth
> expiry, schema drift, or upstream API change. Show me the smoke-test output.

### 22 — Subagent loop
- **Crosses:** The agent file + the last three session transcripts + the trigger that
  fired the loop.
- **Artifact:** A diagnosis identifying the loop trigger, plus a proposed stopping
  condition.
- **Taught in:** Appendix E.

> Iris invoked herself 12 times in a row before I killed it. Read the agent file at
> `.claude/agents/iris.md` and the last session log. Find the loop trigger and propose
> a stopping condition. Don't rewrite the agent yet — diagnose first.

### 23 — Schedule didn't fire
- **Crosses:** The job state file + the cron interpretation + the system wake schedule +
  the prior exit code.
- **Artifact:** A one-line diagnosis naming which of four causes (paused, asleep,
  prior-exit-disabled, cron-misread) explains the miss.
- **Taught in:** Appendix E.

> Scheduled job [ID] should have fired at 6:30 AM. It didn't. Check job state, last
> exit code, the cron interpretation, and whether the machine was awake at fire time.
> Tell me which of those four is the cause.

### 24 — Permission denied unexpectedly
- **Crosses:** `.claude/settings.json` + `.claude/settings.local.json` + the action
  Claude tried.
- **Artifact:** The matching rule named, plus a proposed minimum-scope change to allow
  the case.
- **Taught in:** Appendix E.

> Claude refused to write a file in `~/work/`. Read `.claude/settings.json` and
> `.claude/settings.local.json`. Tell me which rule blocked the write, and propose the
> smallest change to allow this case without opening the door wider.

---

## "When something feels off" jobs (6)

The soft-signal set. These catch drift before it becomes incident. Run most of these
during the Sunday governance hour (Ch 26).

### 25 — Cost trend check
- **Crosses:** 30 days of `/cost` output by agent + a baseline from the prior 30 days +
  Appendix B's "what blows up your bill" list.
- **Artifact:** A trend table → `~/work/journal/cost-{week}.md` with anomalies flagged.
- **Taught in:** Ch 26.

> Pull the last 30 days of token spend by agent. Anything bending up that wasn't
> bending up last week? For each anomaly, hypothesis on cause. Cross-reference
> Appendix B's "what blows up your bill" list before you guess.

### 26 — Conversion-rate trend audit
- **Crosses:** The Notion Leads database (last 7 days vs. trailing 4-week average) + the
  dashboard's leads-by-source tile (Ch 21) + the watchdog-mesh's funnel-anomaly source
  (Ch 17).
- **Artifact:** A trend table → `~/work/marketing/conversion-trend-{week}.md`.
- **Taught in:** Ch 19.

> Compute this week's conversion rate by source from the Notion Leads DB. Compare to
> the trailing 4-week average. For any source where this week is more than 50% below
> average, flag a tier-3 escalation and propose a Slack ping for the watchdog mesh.
> File the table.

### 27 — Quiet-agent audit
- **Crosses:** The scheduled-jobs log + each agent's last-run timestamp + their last
  output's content.
- **Artifact:** A list grouped into "trigger never fired" vs. "agent broke quietly" →
  `~/work/journal/quiet-{week}.md`.
- **Taught in:** Ch 17.

> Which agents haven't fired in the last seven days? For each one, tell me whether the
> trigger never fired (no input matched) or the agent broke quietly (errored or
> returned empty). Don't lump them.

### 28 — Slowness diagnosis
- **Crosses:** Hook overhead measurements + MCP latency samples + CLAUDE.md size +
  session timing.
- **Artifact:** Numbers showing the actual bottleneck, plus a proposed fix.
- **Taught in:** Ch 22.

> My sessions feel slower this week. Find the actual bottleneck: hook overhead, MCP
> latency, CLAUDE.md size, or something else. Measure, don't guess. Show me the numbers
> you found, then propose the fix.

### 29 — Promotion-readiness check
- **Crosses:** The agent's 30-day correction log + the proposed new permission + a
  reversal mechanism.
- **Artifact:** A go/no-go recommendation plus a diff of the agent file (and
  settings.json if the permission scope changes).
- **Taught in:** Ch 9.

> Iris has been drafting for 30 days with zero corrections from me on the [CATEGORY]
> inbox. Should I promote her to send-without-asking on that category? What would
> change about the agent file? What's the smallest reversal mechanism if she botches
> one?

### 30 — Garden weeding
- **Crosses:** Every file in `.claude/` + their last-modified times + their reference
  graph (which agent calls which skill).
- **Artifact:** An audit grouped into never-used / used-once / duplicates / conflicts →
  `~/work/journal/garden-{quarter}.md`. No changes applied.
- **Taught in:** Ch 26.

> Read every file in `.claude/`. Tell me what's stale, redundant, or contradictory.
> Don't change anything yet — just the audit. Group by: never-used, used-once,
> duplicates-of-something-else, conflicts-with-something-else.

---

## Using this library

- When a prompt isn't working, the meta-move is the same as Ch 6's: paste the
  unhelpful output back, say *"this didn't help — what would have helped,"* and let
  Claude refine the prompt with you.
- The four categories map back to four chapters' worth of pattern: daily-drivers to
  Ch 7, agent-authoring to Ch 6 / Ch 13 / Ch 14, debugging to Appendix E, "feels off"
  to Ch 17 and Ch 26.
- If a job here surprises you, walk back to its taught-in chapter — that's where the
  surrounding shape lives.
