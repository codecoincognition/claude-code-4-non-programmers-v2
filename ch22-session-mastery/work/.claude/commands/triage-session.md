---
description: One-keystroke end-of-session hygiene — reports /cost and /context, then asks whether to /compact.
---

# /triage-session

Run my end-of-session hygiene check. Do this, in order:

1. Run `/cost` and report the total session spend, the per-prompt average, and
   the trend of the last several prompts (rising / flat).

2. Run `/context` and report the context-window usage as a percentage, and
   whether it's rising.

3. Based on those two numbers, give me a one-line recommendation:
   - If context is above 60% and I have more than an hour of work left,
     recommend pinning decisions (run `/before-compact`) and then `/compact`.
   - If context is below 60%, tell me I'm fine to keep going.
   - If spend is climbing fast on the last few prompts, flag it.

4. Ask me explicitly: "Compact now? (y/n)". Do NOT run `/compact` unless I say yes.

Keep the whole thing short — this is a thirty-second check, not a report.
