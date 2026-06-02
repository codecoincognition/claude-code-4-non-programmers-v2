---
description: >
  Run the full draft process for a piece of writing — outline, draft,
  cut, add imagery, read aloud — in five explicit steps. Use when the
  user asks to "run the full draft process" or wants the workshop
  treatment, not a one-shot draft.
---

# /draft — the full writing routine

This is a workflow, not a behavior. It fires only when the user asks
for the full process explicitly. (For everyday writing, the
`your-tone` skill applies the voice rules automatically without this
routine — don't run these steps unless asked.)

Load the voice rules from `.claude/skills/your-tone.md` before you
start, and apply them at every step.

Walk through these five steps, showing your work at each:

1. **Outline.** Hook, body, close — three bullets, no prose yet.
2. **First draft.** Compose the piece end to end.
3. **Cut.** Go sentence by sentence. Remove throat-clearing, kill
   redundancy, break long sentences in half.
4. **Add imagery.** One specific image per paragraph — a number, a
   name, a moment. Propose options if a paragraph is bare.
5. **Read aloud.** Check cadence (short, short, longer-with-contrast,
   short). Flag any sentence that stumbles, and fix it.

Then return the final draft. Keep the voice rules from `your-tone.md`
in force the entire time.
