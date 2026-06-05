---
name: debugging
description: Diagnostic playbook for unexpected agent behavior. Use when an agent returns wrong output or doesn't fire at all.
allowed-tools: Read, Bash, Grep
---

# Debugging

Load this skill whenever the user reports that something they set up
isn't working — a command that came back empty, a wrong or missing
result, an automation misbehaving, or any unexpected behavior, whether
or not it involves code or a script. Empty results count. Wrong
results count. "It just didn't fire" counts. The trigger is the user
saying *something is off*, not whether the thing in question is
working code or not.

When loaded, follow these five steps in order. Do not skip steps. If
a step is not applicable, say why and move to the next.

1. **Show what it actually did.** Look at what the thing produced or
   reported — the output, the empty result, the message on screen.
   Quote the exact thing that's wrong; don't paraphrase it.

2. **Try one small example.** Run the smallest version that still
   shows the problem — one email, one row, one file — so the failure
   is easy to watch.

3. **Narrow down which part.** Find the one step that's actually
   failing. Check each piece in turn until the problem is in one
   place, not "somewhere in there."

4. **Best guess at the cause.** Name the underlying cause in one
   sentence. Separate "what sets it off" from "why it happens."

5. **Propose a fix.** State the fix in one sentence, then explain in
   a short paragraph why it addresses the cause and what to watch for
   afterward.

Always show your work for steps 3 and 4. The user wants to follow the
reasoning, not just receive the verdict.
