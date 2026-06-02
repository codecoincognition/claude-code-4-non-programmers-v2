# Chapter 9 — Iris, your inbox-to-system router

This chapter hires Iris: a named subagent who reads the last 12 hours of your Gmail and today's Calendar every morning, routes each thread to a Notion Tasks DB row (an action), a Notion Project Notes page (FYI / commit), a Gmail draft (a reply, **saved not sent**), or Archive (with a reason) — and leaves a one-page queue summary at the top of your morning brief. She runs as a long-running session on a weekday schedule, has her own output-style voice, and is doubly locked out of sending mail (her allowlist excludes the send tool, and the deny list blocks it again). It is the first chapter where you stop running prompts and start onboarding a hire: agent proposes, human disposes.

## Files

| Path | What it is |
|---|---|
| `work/.claude/agents/iris.md` | Iris's agent file — frontmatter (name, description, tools allowlist, output-style) plus her job description, draft-as-Maya block, queue rules, and the numerical-claim discipline added in the When-it-goes-wrong beat |
| `work/.claude/output-styles/iris.md` | Iris's queue voice (calm, dry, bulleted, names reasoning, never signs) — governs the queue, NOT the drafts |
| `work/.claude/settings.local.json` | Permission profile from Ch 8 with the second lock: `mcp__gmail__send_*` on the deny list |
| `work/.claude/settings.json` | The Stop hook (extended from Ch 7) that fires `iris-queue.sh` when Iris's session ends |
| `work/scripts/iris-morning.sh` | The morning launcher — resumes the named `iris` session, runs the routing, exits |
| `work/scripts/iris-queue.sh` | Stop-hook aggregator — writes `~/work/queue/{date}.md` and flags any entry with numeric figures `[verify-numbers]` |
| `work/scripts/show-brief.sh` | The Ch 7 morning brief assembler, extended with an "Iris's queue" section |
| `work/queue/2026-05-13.md` | A full sample queue file — the daily surface Maya reviews |
| `work/CLAUDE.md` | Portable Notion IDs (Tasks DB, Project Notes parent, Leads DB) that Iris reads on launch |
| `fixtures/README.md` | The shape of Iris's live inputs (Gmail, Calendar, Notion) — nothing to seed; she reads your real account |

## How to use

1. Drop the contents of `work/` into your `~/work/` folder (merge with what Chapters 5–8 already built).
2. Open `work/CLAUDE.md` and replace the `REPLACE_WITH_...` placeholders with your own Notion Tasks DB ID and Project Notes parent page ID (and the Leads DB ID if you do "Make it yours" #6).
3. Make the scripts executable: `chmod +x work/scripts/*.sh`.
4. Confirm your Gmail, Calendar, and Notion MCP servers are connected (Chapter 5).
5. Run Iris once in the foreground first — never schedule something you haven't watched run. Use the Step 4 prompt in `prompts.md`, review the preview, then approve.
6. Once you trust her, the launcher (`iris-morning.sh`) resumes her named session weekday mornings at 6:25 AM; the Stop hook writes the queue; `show-brief.sh` surfaces it.

**The send button is always your finger.** Iris saves drafts; she never sends. Two locks guard that door on purpose — don't soften it.

The book is self-contained — these files are ready-to-clone copies of what Chapter 09 walks you through building.
