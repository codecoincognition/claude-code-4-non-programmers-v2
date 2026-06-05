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
- `work/.claude/agents/vendor-researcher.md` — your first **subagent**.
  Read-only (Read, Grep, WebFetch — no Edit/Write/Bash). Reads a tool's
  online documentation and returns a one-page verdict without touching
  your main session. This is the canonical safe shape.
- `work/.claude/skills/debugging.md` — your first **skill**. The five-step
  debugging routine (show what it did → small example → narrow down →
  best-guess cause → propose a fix). This ships with the **fixed,
  behavior-keyed** `description` from the end of the chapter. The chapter
  first shows a broken version whose trigger said *"when debugging code
  or a script"* — that one silently failed to load when Maya reported her
  `triage` automation came back empty (she didn't say "debug" or "code").
  The lesson: a skill's `description` is a *load condition*, so key it to
  behavior ("whenever the user reports that something isn't working") not
  to a language or topic.

### Richer variants (the chapter's "Make it yours" prompts)
- `work/.claude/agents/inbox-digest.md` — daily Gmail summarizer subagent.
  Reads Gmail (via the Ch 5 MCP), classifies threads action/FYI/noise, writes
  a dated digest to `~/work/inbox/`. Read-Gmail + write-to-`~/work/` only — no
  send, no external writes. (This is the bridge to Iris in Chapter 9.)
- `work/.claude/agents/meeting-notes-summarizer.md` — read+write subagent
  that turns a long transcript into 5 bullets + 3 action items and saves
  the summary next to the transcript.
- `work/.claude/skills/copy-variants.md` — behavior skill: whenever you ask
  for copy, always returns three variants (short / long / playful).

### Sample input / fixtures
- `work/scripts/morning-brief.sh` — the bash script the debugging demo
  points at. Earlier drafts had a Wednesday-only timezone bug (Gmail
  window computed in UTC, drifted across the local-time date boundary);
  this version ships the fixed code with a comment at the top explaining
  what changed and why, so you can read the fix end-to-end after the
  debugging skill walks you through diagnosing it.
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
3. Try the subagent: *"Use the vendor-researcher subagent to read
   docs.loopline.com and tell me whether Loopline supports multi-step
   drip automation and how it handles unsubscribes. Delegate — I want
   only the one-page verdict back."*
4. Try the skill: *"My triage came back empty this morning — zero
   threads routed — but my inbox is full of unread mail. Something
   went wrong. Figure out what."* (The debugging skill should
   auto-load and walk the five steps.)
5. Optional: copy `fixtures/sample-meeting-transcript.txt` under `~/work/` and
   run the `meeting-notes-summarizer` subagent on it.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 6 walks you through building.
