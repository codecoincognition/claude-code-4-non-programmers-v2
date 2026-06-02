# Chapter 16 — The launch crew

This chapter builds a five-agent crew under one parent folder that ships a
finished long-form draft across four channels at once. A **producer**
(orchestrator) dispatches four channel writers — LinkedIn, X, one-pager, email —
in parallel, composes a side-by-side launch package, and on your approval hands
the approved channels to the **Buffer MCP** for scheduled publishing (with a
**Gmail-MCP fallback** for email). Every writer loads the same `your-tone`
skill from Chapter 14 and layers thin per-channel rules on top — the pattern the
chapter names **channel specialization via skill layering**: one source of truth
for voice, inheritance not duplication, suppression where a channel demands it
but never overwriting the underlying voice. The new failure mode lives at the
**publishing tail** — work can succeed locally and fail at the gate — so the
producer verifies per-channel gate-readiness at package time, not at schedule time.

## Files

```
ch16-launch-crew/
├── README.md                                  ← this file
├── prompts.md                                 ← every chapter prompt, verbatim & in order
├── work/
│   ├── .claude/
│   │   ├── agents/launch-crew/
│   │   │   ├── producer.md                     orchestrator + Buffer dispatch + gate check + Gmail fallback
│   │   │   ├── linkedin-writer.md              loads your-tone, +LinkedIn rules
│   │   │   ├── x-writer.md                     loads your-tone, +X rules (≤280)
│   │   │   ├── one-pager-writer.md             loads your-tone, +sales one-pager rules
│   │   │   └── email-writer.md                 loads your-tone, +customer-email rules
│   │   └── skills/your-tone/SKILL.md           Maya's brand voice (the Ch 14 dependency, included so the crew runs standalone)
│   ├── work-products/2026-05-08-auto-tag-launch/
│   │   └── draft.md                            sample input the producer reads
│   └── launches/2026-05-08-auto-tag/
│       ├── launch-package.md                   composed output (four artifacts side-by-side)
│       └── one-pager.md                        the channel left as a file (not published)
├── fixtures/
│   └── README.md                               Buffer + Gmail MCP input shapes (your own connected accounts)
└── variants/
    └── instagram-writer.md                     Make-it-yours #1 — adding a channel is adding a file
```

## How to use

1. Drop `work/.claude/` into your `~/work/` so the agents and the `your-tone`
   skill resolve at `~/work/.claude/agents/launch-crew/` and
   `~/work/.claude/skills/your-tone/`. (The chapter already built `your-tone` in
   Chapter 14 — a clone-ready copy is included here so the crew runs on its own.)
2. Make sure the **Buffer MCP** from Chapter 5 is connected (and optionally the
   **Gmail MCP** for the email fallback). See `fixtures/README.md` for the input
   shapes; do not commit your tokens.
3. Point the producer at a draft — the sample lives at
   `work/work-products/2026-05-08-auto-tag-launch/draft.md`. Run the Step 3
   prompt from `prompts.md`.
4. Read the launch package back (Step 4), approve the channels you like, and let
   the producer schedule them via Buffer (Step 5). The channel you don't approve
   stays as a file, exactly like `work/launches/2026-05-08-auto-tag/one-pager.md`.
5. To add a channel, copy `variants/instagram-writer.md` into the crew folder and
   add one line to the producer's dispatch step.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 16 walks you through building.
