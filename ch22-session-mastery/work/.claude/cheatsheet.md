# Session command cheatsheet

The four families of the session command surface. Print this and tape it next
to your laptop for two weeks until the commands are reflex.

## Navigation
- /rewind (Esc Esc)  — roll back to a prior prompt
                       e.g. "the cache key change was wrong; undo back to before it"
- /fork              — branch into a parallel conversation
                       e.g. "try a different approach without losing this one"
- claude --resume    — resume a previous session by ID
                       e.g. "pick up yesterday's debug session"
- Ctrl+G             — open external editor for a long prompt

## Mid-task
- /btw <correction>  — fold a constraint into an in-progress reply
                       e.g. "also append to escalations.log; keep going"
- /compact           — summarize the session to free context
                       PIN DECISIONS FIRST; compactor is lossy

## Situational awareness
- /cost              — total session spend
- /context           — token-window usage %
                       Run both twice an hour during long sessions

## Model and effort
- /model <name>      — switch model (heavier for hard reasoning)
- /effort <level>    — session reasoning intensity (default/high/ultra)
- ultrathink         — one-shot deepest reasoning for a single prompt
- /plan              — enter plan mode (Ch 8) for a risky step

---

## When each command earns its place

| Command | When it earns its place |
|---|---|
| /rewind (Esc Esc) | A few prompts ago was the wrong fork — selectively undo without losing the rest |
| /fork | Try an alternative without committing the main thread |
| /btw | Mid-reply correction without restarting — "by the way, also do X" |
| /cost | Before a long run, or when you suspect you've been burning tokens |
| /context | When responses feel slow — checking whether you're near the model's window |
| /compact | Context is high; pin decisions to a decisions.md first, then compact |
| /model | Switching to a heavier model for one hard reasoning step |
| /effort | Session-level reasoning intensity (default, high, ultra) |
| ultrathink | One-shot deepest-reasoning keyword for a single prompt |
| --resume | Returning to a session after closing the terminal |
| Ctrl+G | Editing a long prompt in your real editor instead of the terminal |
| /plan | Entering plan mode (Ch 8) for a risky step |

## When it bites
1. /compact lossiness — pin decisions before compacting, or you lose load-bearing reasoning.
2. /fork proliferation — forks accumulate; prune them periodically (Appendix I).
3. ultrathink cost — 5-10x a normal prompt; use ~4x a week, not 4x an hour.
4. /model whiplash — switch between decisions, never mid in-flight decision.
