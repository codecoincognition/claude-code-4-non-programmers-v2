# Chapter 6 prompts — copy-paste, in order

Every prompt below is reproduced verbatim from the chapter. By Chapter 6 your
behavioral and contextual lines live in `~/work/.claude/CLAUDE.md` (Chapter 3),
so you no longer type a badge preamble each session.

Open Claude in your work folder first:

    cd ~/work && claude

---

## Step 1 — Author the library-researcher subagent

    I want a subagent that reads source code in third-party libraries and returns a one-page summary of how they handle a specific concern. Write it to .claude/agents/library-researcher.md. Give it only the read tools — no edit, no run, no write. It should never make network calls outside of fetching public repo content. Return only the summary, never the raw code.

Then see what Claude wrote:

    Show me the contents of .claude/agents/library-researcher.md.

---

## Step 2 — Use the subagent for real research

    Use the library-researcher subagent to tell me how the requests Python library handles connection pooling. Don't read the code in this conversation — delegate. I want only the one-page summary back.

---

## Step 3 — Show the difference, concretely

    Now read the same source code yourself, in this conversation, and answer the same question. Then tell me how many tokens of source you loaded versus what the subagent used.

---

## Step 4 — Author the debugging skill

    I want a skill called debugging. When I ask you to debug anything, you should follow these five steps in order: (1) check the logs first, (2) try to reproduce the issue with a minimal example, (3) bisect — narrow down what's actually broken, (4) form a hypothesis about the root cause, (5) propose a fix and explain why it works. Write it to .claude/skills/debugging.md with a description that triggers it on any debugging request.

Then see what Claude wrote:

    Print .claude/skills/debugging.md so I can see what you wrote.

---

## Step 5 — Trigger the skill on a real bug

    There's a bug in my morning-brief.sh script — it's writing empty briefs on Wednesdays only. Other days are fine. Debug it.

---

## When it goes wrong — the skill description was too narrow

    You didn't load the debugging skill on that bash script — I think the description is too narrow (it says "Python code" but my script is bash). Read .claude/skills/debugging.md, look at its description field, and rewrite it so it triggers on any debugging request regardless of language. Then re-run the bug report.

---

## Step 6 — Audit the .claude/ folder

    List everything in .claude/ and tell me which construct each file or folder belongs to.

---

## Make it yours — five follow-up prompts

### 1. The bridge to Iris — a Gmail-read + filesystem-write subagent

    Wrap this as a subagent: a daily Gmail summarizer named `inbox-digest` that reads my last 24 hours of Gmail (using the MCP from Ch 5), classifies each thread (action / FYI / noise), and writes a digest to `~/work/inbox/digest-{date}.md`. Read Gmail + write to `~/work/` only — no send permission, no external writes.

### 2. A summarizer subagent

    Wrap this as a subagent: a meeting-notes summarizer that reads a transcript file and returns a 5-bullet summary plus 3 action items. Read-only access only — no edit, no run.

### 3. A copy-variants skill

    Wrap this as a skill: 'when I ask you to write copy, always offer three variants — one short, one long, one playful.' Trigger on any prompt that asks me to write copy, marketing language, or social posts.

### 4. Audit your subagents' allowlists

    Audit my .claude/agents/ folder. For each subagent, tell me what tools it can use and whether the allowlist is broader than the work needs. Recommend any I should narrow.

### 5. Promote a slash command to a skill

    Convert my /triage slash command into a skill so it triggers automatically on any morning prompt instead of needing me to type the slash. Keep the command working too, in case I want to invoke it explicitly.

---

## Test yourself in 60 seconds

    Use my library-researcher subagent to summarize the Anthropic SDK README in one page.

    My script crashes on line 42 with a KeyError. Walk me through it.

    Read ~/work/.claude/agents/library-researcher.md and tell me which of its four parts is the frontmatter, the description, the tools list, and the body.

Stuck? Run:

    Audit my Chapter 6 setup against the chapter spec.
