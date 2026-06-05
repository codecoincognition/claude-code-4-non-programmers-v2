---
description: Show the parent thread's spend (/cost) before switching into a conversation copy with /branch, so you commit to the branch with eyes open.
---

# /safe-branch

I'm about to switch this conversation into a copy of itself using `/branch`
(the original session stays preserved as a separate `--resume`-able session;
I move into the copy). Before I commit to the switch, I want to see what the
parent thread has cost.

Do this, in order:

1. Run `/cost` and report the parent thread's total spend and the trend of the
   last several prompts.

2. Tell me, in one line, whether branching is cheap insurance here (parent spend
   is high enough that I don't want to risk losing it) or whether the parent is
   cheap enough that a plain `/rewind` might be the simpler move.

3. Then run `/branch` to switch me into a copy of the conversation from this
   point. Confirm the new conversation is live and that the original is
   preserved as a separate session I can `--resume` later.

This pairs `/cost` with `/branch` so I never switch blind.

Note: this wraps `/branch` (switch myself into a conversation copy), not
`/fork` (which spawns a background subagent that inherits the conversation
and chases a directive while I keep prompting in the main thread). Different
commands, different jobs — see Ch 22.
