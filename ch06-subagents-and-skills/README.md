# Chapter 6 — Hire your first staff member (subagents and skills)

Chapter 6 has you author your first two non-prompt artifacts by *prompting*
Claude to write them: a **subagent** (a separate Claude with its own room and
its own toolbox) and a **skill** (an instruction card Claude picks up when it
recognizes the situation). The subagent solves context pollution — research
runs in an isolated room and returns only the answer. The skill solves
re-typing — a five-step debugging routine that loads automatically on any bug
report. This folder ships ready-to-clone copies of both, plus the richer
variants from the chapter's "Make it yours" section and a runnable demo input.

## File-by-file

### The two artifacts the chapter walks you through building
- `work/.claude/agents/library-researcher.md` — your first **subagent**.
  Read-only (Read, Grep, WebFetch — no Edit/Write/Bash). Reads source in a
  third-party library and returns a one-page summary without touching your
  main session. This is the canonical safe shape.
- `work/.claude/skills/debugging.md` — your first **skill**. The five-step
  debugging routine (logs → reproduce → bisect → hypothesize → fix). This
  ships with the **fixed, language-agnostic** `description` from the end of
  the chapter. The chapter first shows a broken version whose trigger said
  *"when debugging Python code"* — that one silently failed to load on a bash
  script. The lesson: a skill's `description` is a *load condition*, so key it
  to behavior ("whenever the user reports a bug") not to a language or tool.

### Richer variants (the chapter's "Make it yours" prompts)
- `work/.claude/agents/inbox-digest.md` — daily Gmail summarizer subagent.
  Reads Gmail (via the Ch 5 MCP), classifies threads action/FYI/noise, writes
  a dated digest to `~/work/inbox/`. Read-Gmail + write-to-`~/work/` only — no
  send, no external writes. (This is the bridge to Iris in Chapter 9.)
- `work/.claude/agents/meeting-notes-summarizer.md` — read-only subagent that
  turns a long transcript into 5 bullets + 3 action items.
- `work/.claude/skills/copy-variants.md` — behavior skill: whenever you ask
  for copy, always returns three variants (short / long / playful).

### Sample input / fixtures
- `work/scripts/morning-brief.sh` — the bash script the debugging demo points
  at (Step 5 reads `~/work/scripts/morning-brief.sh`). It contains the exact
  Wednesday-only timezone bug the chapter diagnoses, so the debugging skill is
  reproducible end-to-end.
- `fixtures/sample-meeting-transcript.txt` — a tiny synthetic transcript to run
  the `meeting-notes-summarizer` subagent against.
- `fixtures/README.md` — what the Gmail and transcript inputs look like, since
  the real ones come from your own accounts (we don't ship private data).

## How to use

1. Copy the contents of `work/` into your own `~/work/` folder:
   ```
   cp -R work/.claude ~/work/.claude
   cp -R work/scripts ~/work/scripts
   ```
   (Merge with whatever is already in `~/work/.claude/` from Chapters 3–5 —
   these only add `agents/` and `skills/` entries.)
2. Confirm Claude sees them: `claude agents list` and `claude skills list`.
3. Try the subagent: *"Use the library-researcher subagent to tell me how the
   requests Python library handles connection pooling. Delegate — I want only
   the one-page summary back."*
4. Try the skill: *"There's a bug in my morning-brief.sh — it writes empty
   briefs on Wednesdays only. Debug it."* (The debugging skill should
   auto-load and walk the five steps.)
5. Optional: copy `fixtures/sample-meeting-transcript.txt` under `~/work/` and
   run the `meeting-notes-summarizer` subagent on it.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 6 walks you through building.
