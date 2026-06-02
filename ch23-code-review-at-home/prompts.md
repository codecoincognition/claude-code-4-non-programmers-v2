# Prompts — Chapter 23: Code review at home

Every prompt from the chapter, verbatim and in order.

---

## Maya's Friday review

### Step 1 — Switch on auto mode

```
/auto
```

```
Review the three files I authored today: ~/work/dashboard/build.sh, ~/work/.claude/commands/cancel-leak.md, ~/work/scripts/kill-switch.sh. I want each one's review output filed at ~/work/reviews/2026-05-08/{file}.md. At the end, write a review-summary.md at the same path.
```

### Step 3 — /security-review on the cancellation slash command

```
Apply both fixes from the cancel-leak.md review. Move the Stripe key to ~/.env and update the slash command to reference $STRIPE_API_KEY. Tighten the auto-approval threshold to verified URL + DOM landmark match.
```

### Step 4 — /sandbox on the kill-switch shell script

```
Apply both kill-switch.sh fixes from the sandbox results — input length validation and the osascript fallback. Re-run the sandbox after.
```

### Step 5 — /batch — apply one fix to many files at once

```
All six refresher scripts in ~/work/dashboard/refreshers/ should follow the same error-handling pattern that /simplify proposed for build.sh — set -euo pipefail at the top, exit-code propagation. Apply that pattern to all six in parallel. Show me a per-file diff before commit.
```

### Step 6 — Consolidate the review session

```
File a review-summary.md at ~/work/reviews/2026-05-08/ summarizing all four review actions — what was found, what was fixed, what's still outstanding. End with a one-line "OK to commit" signal I can read and approve.
```

### Step 7 — Personalize the review posture as a slash command

```
Author ~/work/.claude/commands/review-mine.md — a slash command that runs the same auto-mode review I just walked through, on whatever set of files I pass as $ARGUMENTS. Save my preferred review-output folder structure (~/work/reviews/{today's-date}/). End the run with a review-summary.md and the OK-to-commit signal. If no $ARGUMENTS are passed, default to "every file I authored today" (modified after midnight).
```

```
Author ~/work/.claude/auto-mode-hints.md — three rules I learned today: .claude/commands/ files are slash commands and get /security-review (not /simplify); shell scripts always /sandbox first; same-pattern files in a folder of 3+ get /batch. Auto mode reads this file at session start.
```

---

## Devon's Tuesday — reviewing a teammate's PR

### Step 8 — Devon scopes the review to the PR diff

```
/review-mine — files changed in PR #284. Use auto mode. I want the security-review lens emphasized; this PR adds an authentication endpoint. Run /sandbox on any new shell scripts. /batch any pattern that repeats across files. File the review at ~/work/reviews/pr-284/.
```

---

## When it goes wrong — the auto-mode misclassification

```
Auto mode misclassified cancel-leak.md as docs instead of as a permission-granting slash command. Two fixes: (1) re-run /security-review explicitly on that file (already done — see today's summary); (2) update auto-mode-hints.md to include the rule "anything under ~/work/.claude/commands/ is a slash command and gets /security-review, not /simplify, regardless of content."
```

---

## Make it yours — five (six) follow-up prompts

```
Run /review-mine on every file I authored this week (modified after Monday). File the review folder with this week's date.
```

```
Author a Stop hook (Ch 7) that runs /review-mine on any new files in ~/work/.claude/ whenever I close a session — so I never commit an unreviewed slash command.
```

```
Add a fourth review lens to my auto-mode-hints.md — /cost-review — for any file that calls expensive MCPs (browser use, computer use, ultrathink). Define the rule and write the hint.
```

```
Audit my ~/work/.claude/auto-mode-hints.md quarterly — pull the past 90 days of auto-mode picks, find the ones I overrode, and propose new hints from the override patterns. The hints file should grow from feedback, not from guessing.
```

```
Run /security-review on my full ~/work/.claude/ folder weekly via the watchdog mesh from Ch 17 — escalate HIGH findings to my Slack.
```

```
/security-review on ~/work/site/launch/api/submit.ts (the Ch 19 serverless function) before Wednesday's launch email goes out. Audit for OWASP-style holes (OWASP being the standard catalog of common web-security holes) — input validation on the form fields, env-var leak risk on NOTION_TOKEN, rate limiting on the endpoint, CORS misconfig (CORS being the browser rule controlling which sites may call your endpoint) that would let a third-party site POST to /api/submit, error messages that leak stack traces. File findings at ~/work/reviews/launch-pre-flight-{date}/.
```

---

## Test yourself in 60 seconds

```
Run /review-mine on a recently changed file in ~/work/. Confirm the auto-mode classifier picked the right posture.
```

```
Run /sandbox on a Claude-authored shell script before any first execution. Confirm it ran in isolation.
```

```
Open ~/work/.claude/auto-mode-hints.md and tell me how many override rules it now contains.
```

```
audit my Chapter 23 setup against the chapter spec
```
