---
description: Show the parent thread's spend (/cost) before branching, so you commit to a new fork with eyes open.
---

# /safe-fork

I'm about to branch this conversation into a parallel thread. Before I commit
to the fork, I want to see what the parent thread has cost.

Do this, in order:

1. Run `/cost` and report the parent thread's total spend and the trend of the
   last several prompts.

2. Tell me, in one line, whether forking is cheap insurance here (parent spend
   is high enough that I don't want to risk losing it) or whether the parent is
   cheap enough that a plain `/rewind` might be the simpler move.

3. Then run `/fork` to branch into a parallel conversation from this point, and
   confirm the new conversation is live and the parent is preserved.

This pairs /cost with /fork so I never branch blind.
