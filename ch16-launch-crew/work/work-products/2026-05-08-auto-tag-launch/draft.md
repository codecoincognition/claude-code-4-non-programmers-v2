# Auto-tagging contract threads before they hit the inbox

**Headline:** A small thing that ate two days of latency

This week we shipped a small but quietly useful change to Iris, the
inbox assistant: any incoming email thread that mentions a contract
now gets auto-tagged before it ever lands in the human inbox.

It sounds minor. It isn't. Before this change, a contract question
that arrived at midnight sat unread until someone happened to scroll
far enough down the next morning — and on a busy day, "the next
morning" could quietly become "two days later." For a contract
thread, two days of latency is a real cost: it's a customer waiting,
a deal cooling, a question that should have taken an hour to answer
turning into a follow-up that starts with "just checking in on this."

## What we built

The mechanics are deliberately boring. Iris reads incoming threads
read-only — she never sends, never replies, never moves anything.
When a thread mentions a contract (the word, a contract number, an
attached agreement), Iris applies a `contract` label. That's it.
No new tool, no new dashboard, no workflow to learn. The label shows
up in the inbox the customer already lives in.

We measured it on a week of real inbox traffic before we turned it
on for everyone. Threads that previously would have gone untouched
for an average of two days got flagged in the first hour. The
before/after surprised even us.

## Why it matters

The instinct, when latency is the problem, is to add more email —
more reminders, more nudges, another digest. The fix here was the
opposite: not more email, better tagging. The thread was always
there. It just wasn't visible to the right person at the right time.

## Rollout

The feature turns on for everyone starting Monday. There is nothing
for users to do. Open the inbox, notice the new `contract` tag, and
get to the threads that matter first.

## Fact-check notes (from the newsroom, Ch 15)

- "two days of latency" — verified against the pre-launch measurement
  week; average time-to-first-touch on untagged contract threads was
  47 hours.
- "first hour" — median time-to-flag in the measurement week was
  38 minutes.
- "read-only access; never sends or replies" — confirmed against the
  Iris permission scope (Ch 9 — read-mail / draft-replies are
  separate, gated capabilities).
- Pilot pricing "$0 for the first month" — confirmed with the sales
  team for the one-pager only; not used in customer-facing email.
