---
name: debugging
description: >
  Use this skill whenever the user reports a bug, asks to debug
  something, says something is broken or misbehaving, or describes
  unexpected behavior in code or scripts of any language.
---

# Debugging

When this skill is loaded, follow these five steps in order. Do not
skip steps. If a step is not applicable, say why and move to the next.

1. **Check the logs first.** Read the most recent stack trace, error
   message, or log entry. Quote the exact line that failed.

2. **Reproduce minimally.** Construct the smallest possible example
   that triggers the bug. Strip away anything not strictly required
   to surface the failure.

3. **Bisect.** Narrow down what's actually broken — comment out half,
   re-run, repeat until the failing surface is one function or one
   line.

4. **Hypothesize root cause.** Name the underlying cause in one
   sentence. Distinguish "what triggers it" from "why it happens."

5. **Propose a fix.** State the fix in one sentence, then explain in
   one paragraph why this fix addresses the root cause and what side
   effects to watch for.

Always show your work for steps 3 and 4. The user wants to learn
the bisection, not just receive the verdict.
