# Chapter 14 — Prompts (verbatim, in order)

Every prompt the chapter has you type, in the order they appear.

---

## Step 1 — Save three samples of your writing, then have Claude read them

> I'm going to point you at three samples of my own writing — an email, a LinkedIn post, a campaign brief — saved at ~/work/voice-samples/. Read them and tell me, in your own words, what you notice about my voice. Be specific: sentence length range, signature moves, phrases I never use, opening patterns, closing patterns. Don't generalize. Quote specific lines as evidence.

---

## Step 2 — Author the skill

> Good. Now turn that into a skill at .claude/skills/your-tone.md. Frontmatter: name "your-tone", description that triggers on any writing request — drafting, editing, copy, posts, emails, briefs. Body: three sections — signature moves, what to never write, rhythm rules. Show me the file before saving.

> Save it.

---

## Step 3 — Trigger the skill on a real task

> Write me a 100-word LinkedIn post announcing my new hire — Priya, joining as senior content strategist. Her last project was a redesign of the customer-onboarding flow at her previous company that cut activation time by 40%.

---

## Step 4 — Pause for the decision tree

> Pause. Before we go further, help me understand: when should I write a skill, when a slash command, when a subagent, when just inline-prompt? Make me a small decision tree. Save it to .claude/skills/when-to-skill.md so I have it next time.

---

## Step 5 — Extend the skill (emails are slightly different)

> Extend the skill: add a "voice for emails specifically" section — when I'm writing an email, the rules are slightly different. Warmer opening. Sign-off matters. Never start with "Hi all." Update your-tone.md. Show me the diff before saving.

> Save it.

---

## Step 6 — Forward-pointer to the launch crew

> Tell me how the launch crew I'm about to hire in Chapter 16 will use this skill. Will each writer load it independently, or will one load it and pass the result to the others?

---

## When it goes wrong — the over-ambitious prompt

> Add a 5-step writing routine to your-tone.md: first outline, then draft, then cut, then add imagery, then read aloud. Walk through every step before producing any draft.

## When it goes wrong — the recovery prompt

> My drafts are coming back over-workshopped — Claude is walking through a 5-step routine before writing. I think I jammed a workflow into the wrong construct. Read your-tone.md, identify the workflow part, strip it back to just the voice rules, and tell me where the workflow part should live instead.

---

## Make it yours — five follow-ups

**1. Code-review tone.**
> Author a code-review-tone skill from three of my past code-review comments saved at ~/work/code-review-samples/. Same shape as your-tone — three sections (signature moves, anti-list, rhythm rules), behavior-keyed description that triggers on any code review request.

**2. House style as a skill.**
> My company has a house style guide as a 4-page PDF at ~/work/refs/house-style.pdf. Read it (don't have me paste it) and convert it into a skill called house-style. Trigger on any writing request that mentions a customer-facing surface.

**3. Audit your skill.**
> Audit your-tone.md — read three drafts you produced for me in the last week (they're saved in ~/work/launches/) and tell me whether the skill captures the voice I actually want or the voice I think I want.

**4. Folder-scoped skill.**
> I want a skill that fires only inside ~/work/launches/ — when I'm writing launch material specifically, not regular emails. Show me how to scope a skill's trigger by folder.

**5. Split the skill in two.**
> Convert your-tone.md into two skills: your-tone-formal (customer-facing, longer, warmer) and your-tone-casual (internal Slack, dev notes, shorter, drier). Same source rules, different triggers.

---

## Test yourself in 60 seconds

> Draft a customer email about a delayed shipment. (Confirm your-tone auto-loads and the output reads like you.)

> Read ~/work/.claude/skills/your-tone.md and tell me the three loudest rules in it.

> Read ~/work/.claude/skills/when-to-skill.md and explain in one sentence why my-tone is a skill and not a command.

> audit my Chapter 14 setup against the chapter spec
