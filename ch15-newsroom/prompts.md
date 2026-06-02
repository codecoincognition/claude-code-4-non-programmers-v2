# Chapter 15 — The newsroom · Prompts (verbatim, in order)

Every prompt the chapter has you run, in the order it appears.

---

## Step 1 — Author all four agents in one prompt

> Author my newsroom: four subagents under .claude/agents/newsroom/ — editor, researcher, fact-checker, headline-writer. Each one is a separate file. The editor orchestrates the others (dispatches researcher + fact-checker in parallel, awaits both, composes a draft, dispatches headline-writer with the draft, awaits, presents draft + headline options). Researcher has read access plus the personal-data MCP from Chapter 13. Fact-checker has read access plus the spec file path the user passes in. Headline-writer loads the your-tone skill. Editor presents results to the user; she doesn't write prose herself. Show me the four files before saving.

## Step 2 — Read the editor's orchestration grammar

> Read the editor file back to me — I want to see exactly how she dispatches the other three. Highlight the parallel-dispatch part and the hand-off part.

## Step 3 — Run a real one — Friday's auto-tag launch

> OK — let's run a real one. Brief: announcement for Friday's launch of the new auto-tag feature. Spec is at ~/work/specs/auto-tag.md. Past launches are in the personal-data MCP. Send it to the editor.

## Step 4 — Pull each agent's work as a separate artifact

> Show me what each agent did individually — pull the research summary, the fact-check report, and the headline candidates as separate artifacts. I want to see each agent's work before reading the editor's composition.

## Step 5 — Pick a headline, tighten it, ship the package

> Pick headline #3, but tighten it — it's a clause too long. Then ship the final draft to ~/work/work-products/2026-05-08-auto-tag-launch/draft.md along with the headline.

## Step 6 — Diagnostic — who loads the voice file?

> Let me see the four agent files side by side. Tell me, for each one: does it load your-tone? Why or why not?

---

## When it goes wrong — recovery prompt

> The headline candidates don't sound like me — I think the headline-writer isn't loading your-tone. Open .claude/agents/newsroom/headline-writer.md, check whether it has access to skills, and fix it. Then re-run the headline step on the same draft.

---

## Make it yours — five follow-up prompts

**1. Add an image-prompter.**
> Add a fifth agent to the newsroom: image-prompter. Her job: read the final draft and headline, produce 3 image-generation prompts that match my voice. Read-only on the draft.

**2. Sequential vs. parallel.**
> Convert the newsroom from sequential-after-parallel to fully sequential — researcher first, then fact-checker, then drafter, then headline. Compare run times and discuss when sequential is the right move.

**3. Tighten the fact-checker.**
> My fact-checker is over-flagging — it's marking standard marketing claims as unverified. Look at the agent's system prompt and tighten its definition of 'fact'.

**4. Author a board-memo team.**
> Author a board-memo newsroom under .claude/agents/board-memo/ — same shape, four agents (researcher, drafter, devil's advocate, summarizer). Use the newsroom from this chapter as the structural template.

**5. Determinism check.**
> Run the auto-tag launch through the newsroom three times in a row and tell me what's deterministic about the output and what's variable. Where do I need to lock in randomness with explicit prompts?

---

## Test yourself in 60 seconds

1. > Run the editor on this brief: {one-line brief}. I want a 1,500-word launch announcement in my voice.
2. > Read ~/work/.claude/agents/newsroom/editor.md and tell me which specialists it dispatches in parallel and which in sequence.
3. > Audit the headline-writer's tools allowlist and confirm it can load ~/work/.claude/skills/your-tone.md.

Stuck? > audit my Chapter 15 setup against the chapter spec
