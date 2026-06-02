# Appendix A — Prompt Library

A ready-to-use catalog of the 30 cross-system jobs from Appendix A of the book.

## What's here

- **`prompts.md`** — all 30 jobs, organized into four categories
  (Daily-driver, Agent-authoring, Debugging, "When something feels off").
  Each entry lists what systems it crosses, the artifact it produces, a
  representative prompt, and the chapter that taught the pattern.

## How to use it

1. Find a job that matches what you're trying to do.
2. Copy the prompt grammar block (the indented quote).
3. Replace the `[ALL-CAPS-WITH-DASHES]` placeholders with your specifics.
4. Run it inside a `claude` session from your `~/work/` folder.

These are not chat-shaped prompts — each crosses two or more systems (an MCP, a
subagent, a scheduled job, the filesystem). They assume you have built the staff
described in the book. Strip the agent names (Iris, Reuben, the newsroom crew) and
swap in your own; the *shape* of each job is the reusable part, not the names.

## Adapting to your setup

- Paths like `~/work/journal/` and `.claude/agents/` are the book's conventions —
  adjust to your own folder layout.
- MCP references (Gmail, Notion, Stripe, PostHog, Slack) assume those servers are
  connected. Substitute the equivalents you actually run.
- If a prompt underperforms, paste the weak output back and ask "what would have
  helped" — several of the book's prompts were tuned exactly that way.
