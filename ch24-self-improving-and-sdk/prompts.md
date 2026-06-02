# Chapter 24 — Prompts, verbatim and in order

Every prompt the chapter has the reader type, in the order they appear.

---

**1. Run /insights against 30 days of session history**

```
/insights --last 30d
```

---

**2. /insights-to-skills — pattern 1 (morning calendar follow-up)**

```
/insights-to-skills --pattern 1
```

Gate answer Devon gives: *"yes, keep doing this for at least the next quarter."*

---

**3. /insights-to-skills — pattern 2 (Friday summary)**

```
/insights-to-skills --pattern 2
```

Gate answer Devon gives: *"changing in two weeks; don't generate."* (Skill is NOT authored.)

---

**4. Author the meta-judge for Iris**

```
Author a meta-judge agent at ~/work/.claude/agents/meta-judge.md. Its job: read Iris's output (the Notion Tasks DB rows + Project Notes pages Iris wrote in the last 24 hours), grade each one against three criteria — was the routing correct (action vs FYI vs commit), is the auto-drafted reply on tone, did Iris respect any thread tags I'd set manually. Surface disagreements as a Slack ping, one ping per disagreement, with the Notion link inline. Run on a daily schedule at 8:30 AM, before /triage.
```

---

**5. Scheduling deep dive**

```
/schedule --deep
```

---

**6. Build the Agent SDK script for the dashboard CI build**

```
Build me an Agent SDK script that runs the dashboard build in a CI runner. The script should: read the same six refresher scripts in ~/work/dashboard/refreshers/, run the build (the build.sh I reviewed in Ch 23), deploy via Vercel, and post the deploy URL to my Slack #devon-deploys channel. File it at ~/work/sdk/dashboard-ci/. Include package.json, the script, a GitHub Actions workflow file, and a README explaining the env vars I need.
```

---

**7. Make the three-layer architecture explicit**

```
Walk me through the three layers — slash commands, subagents, SDK. For each of the eight things I've built, tell me which layer it belongs to and why. File the explanation at ~/work/.claude/three-layer.md so I have it for reference.
```

---

**8. Cowork dispatch evaluation**

```
For the dashboard build that now runs in GitHub Actions, evaluate whether moving it to Claude Cowork dispatch instead would be better. Compare cost over a month, compare reliability, compare the operations overhead. Be honest about cowork's GA status as of the date of this evaluation.
```

---

**9. Author the insights-config gate file (When-it-goes-wrong recovery)**

```
Author ~/work/.claude/insights-config.md with the gate question and any other policies for /insights-to-skills. The gate question must fire before every skill commit, not just the first one. Default answer is "no — don't author" if I don't respond within 60 seconds. Better to under-author than over-author.
```

---

## Make-it-yours follow-up prompts

1. *"Run `/insights --last 90d` and propose three skills. Use the gate to commit only the ones I'll actually use next quarter. Tag each authored skill with provenance."*

2. *"Move the watchdog mesh from my Mac mini to a small VPS. Compare cost over a month and tell me whether the monthly $5 versus the Mac mini's electricity + always-on commitment is worth the change. Don't move anything yet — just compare."*

3. *"Wire `/review-mine` (Ch 23) into the dashboard CI runner so every dashboard build is reviewed before deploy. The review's OK-to-commit signal becomes the deploy's go/no-go signal."*

4. *"Author a second meta-judge agent that grades the watchdog mesh's escalation calibration weekly — find the false positives (escalations that shouldn't have escalated) and the false negatives (incidents that should have escalated but didn't). Propose rubric tightenings."*

5. *"For each of my eight built jobs, tell me which one is on the wrong layer (slash command running unattended; SDK doing one-off work). Propose the move and tell me what changes."*

6. *"Author a GitHub Actions pipeline at `~/work/site/launch/.github/workflows/variants.yml` that deploys variants of the Ch 19 landing page from feature branches. Each push to a `headline-variant/*` branch deploys a Vercel preview URL. The Agent SDK script reads conversion data for each variant from the Notion Leads DB (group by `utm_campaign` carrying the branch name) plus the PostHog `headline_variant` super-property, computes the conversion-rate delta with confidence interval, and posts the winning variant's metrics to Slack #devon-launches once each variant has at least 500 page views. The pipeline gates the merge-to-main on a winner being declared."*

---

## Chapter-end "test yourself" prompts

1. *Run `/insights` against last month's session history. Confirm the gate fires before any new skill auto-installs.*
2. *Open `~/work/.claude/three-layer.md` and tell me which jobs live at slash, subagent, and SDK layers.*
3. *Show me `~/work/sdk/dashboard-ci/` and confirm the GitHub Actions workflow is wired to run nightly.*

Stuck? *"audit my Chapter 24 setup against the chapter spec"*
