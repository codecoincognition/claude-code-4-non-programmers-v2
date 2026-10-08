# Pattern — log approved agent replies as decisions

**Status:** Working. Used more than once.

## The play

When an agent (Iris, Atlas, Reuben) drafts something you approve that encodes a
real call — a policy, a no, an exception — log it as a decision in the agent's
`decisions/` folder. The next similar case gets answered consistently because the
prior call is on disk and linkable.

## Why it works

- Turns one-off approvals into reusable policy.
- The agent can read its own past decisions before drafting the next reply.
- The graph view shows which agents accumulate the most decisions — a signal of
  where you're still making the same call repeatedly.

## Where it's shown up

- [[../projects/iris/decisions/2026-05-04-refund-window-30-days]] — refund window
- Atlas competitor calls (Ch 10) — same shape, different folder

## Links

- [[../projects/iris/README]] — the inbox agent that produced the first one
