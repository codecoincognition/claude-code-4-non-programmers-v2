# Chapter 6 prompts — copy-paste, in order

Every prompt below is reproduced verbatim from the chapter. By Chapter 6 your
behavioral and contextual lines live in `~/work/.claude/CLAUDE.md` (Chapter 3),
so you no longer type a badge preamble each session.

Open Claude in your work folder first:

    cd ~/work && claude

---

## Step 1 — Author the vendor-researcher subagent

    I want a subagent that reads a tool's online documentation and answers a specific question about it — what it does, the gotchas, and what it can't do. Write it to .claude/agents/vendor-researcher.md. Give it only the read tools — no edit, no run, no write. Return only the one-page verdict, never a wall of raw doc text.

Then see what Claude wrote:

    Show me the contents of .claude/agents/vendor-researcher.md.

---

## Step 2 — Use the subagent for real research

    Use the vendor-researcher subagent to tell me whether Loopline supports multi-step drip automation and how it handles unsubscribes and consent. Its docs are at docs.loopline.com. Don't read the docs in this conversation — delegate. I want only the one-page verdict back.

---

## Step 3 — Show the difference, concretely

    Now read the same docs here in our main conversation and answer the same question. Then tell me — in plain English — how much of my conversation space got chewed up versus how little came back when the subagent did it.

---

## Step 4 — Author the debugging skill

    I want a skill called debugging. When I ask you to figure out why something's broken, follow these five steps in order: (1) show me what it actually did, (2) try it on one small example, (3) narrow down which part is failing, (4) give me your best guess at the cause, (5) propose a fix and explain why it works. Write it to .claude/skills/debugging.md with a description that triggers whenever I'm trying to debug something.

Then see what Claude wrote:

    Print .claude/skills/debugging.md so I can see what you wrote.

---

## Step 5 — Trigger the skill on a real bug

    My triage came back empty this morning — zero threads routed — but my inbox is full of unread mail. Something went wrong. Figure out what.

---

## When it goes wrong — the skill description was too narrow

    You didn't load the debugging skill — I think the description is too narrow (it says "code or a script," but I was reporting that an automation came back empty). Read .claude/skills/debugging.md, look at its description field, and rewrite it so it triggers whenever I report that something I set up isn't working — empty results, wrong results, anything misbehaving, code or not. Then re-run on the triage problem.

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

    Use my vendor-researcher subagent to read a tool I'm considering — here's its docs URL — and give me the one-page verdict.

    My weekly-review command came back empty this morning — something's off. Figure out what.

    Read ~/work/.claude/agents/vendor-researcher.md and tell me which of its four parts is the frontmatter, the description, the tools list, and the body.

Stuck? Run:

    Audit my Chapter 6 setup against the chapter spec.
