# Chapter 26 — The Sunday-night governance hour

> *The closing chapter introduces no new primitives. It introduces two
> practices: the Sunday-night governance hour, and the three-question rubric
> for when to fire an agent. This folder ships the two artifacts those
> practices produce — a five-line weekly checklist and an append-only
> fire/keep/rebuild log.*

This is the only chapter in the book whose deliverable is a habit, not a file.
The files in `work/governance/` exist to support the habit, not to replace it.

## What's in this folder

| File | What it is |
|---|---|
| [`prompts.md`](./prompts.md) | The chapter's key prompts — inventory walk, escalation-pattern review, fire/keep/rebuild rubric, rubric-tightening, skill audit, checklist-writing, morning-forward read |
| [`work/governance/sunday-checklist.md`](./work/governance/sunday-checklist.md) | The five-line weekly checklist the chapter authors. Open it every Sunday at 7 PM. |
| [`work/governance/log.md`](./work/governance/log.md) | The append-only fire/keep/rebuild log. One line per decision. Seeded with one example entry showing the format. |

## How to use the hour

One hour, every Sunday evening. Tea, not coffee. Five steps:

1. **Inventory the folder.** Walk `~/work/.claude/` — every CLAUDE.md, every
   command, every agent, every skill, every hook. Note anything last invoked
   more than four weeks ago.
2. **Read the logs.** This week's `~/work/watchdog/escalations.log`,
   cancellation log, dashboard build cron. Surface any false-positive pattern
   worth tightening.
3. **One fire / keep / rebuild decision.** Pick the least-active artifact from
   step 1 and run the three-question rubric (invoked in 4-8 weeks? superseded
   by something newer? need still real but implementation poor?).
4. **Tighten one rubric.** Pick a monitor or hook that misfired this week.
   Diff before saving.
5. **Audit one skill.** Pull three recent pieces. Compare them to the skill's
   rules. Update one rule if drift is real.

The non-negotiable: the hour exists on your calendar even when nothing is
wrong. It's a placeholder for *attention*, not for action.

## The three-question rubric for firing an agent

| Question | If yes → | If no → |
|---|---|---|
| Has it been invoked in the past 4-8 weeks? | **Keep** — it's earning its place | Continue |
| Was it superseded by a newer agent doing the same work better? | **Retire** — archive the file with a one-line reason; do not delete | Continue |
| Is the *need* still real but the *implementation* now fits poorly? | **Rebuild** — write a new agent for the current shape of the work; archive the old | **Keep** — you'll need it again; leave in place |

Retired agents go to `~/work/.claude/retired/`. **Archive, don't delete.** The
next time you need a similar agent, you start from the retired file, not from
a blank document. The retired folder is institutional memory.

## What this folder deliberately does NOT contain

- No subagent file, no skill file, no hook config. The chapter introduces no
  new primitives — only practice.
- No script that runs the governance hour for you. The whole point is that you
  sit with the folder yourself. You can have Claude *run the audit* (see prompt
  variant 1 in the chapter's *Make it yours* section), but the *decisions*
  remain yours.
- No formal log schema. The log is one line per decision. Date, what you did,
  why. If you find yourself needing a richer schema, you're over-engineering.

## When you skip the hour

The "When it goes wrong" section of the chapter spells out the failure mode:
three months of skipping turns the weekly hour into an hour-and-a-half audit.
Six months of skipping means starting over. The recovery prompt — *"my
.claude/ has overgrown; run a full governance audit"* — works, but it's
expensive. The cheap version is the regular practice.
