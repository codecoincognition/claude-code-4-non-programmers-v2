# Watchdog fixtures

The watchdog mesh, orchestrator, and kill-switch hook are built in earlier
chapters (Ch 16 watchdog mesh, Ch 17 launch crew / kill-switch). This folder
exists only to make Chapter 22's scenes runnable in isolation, with synthetic
data — no private state.

## escalations.log

`../escalations.log` is the file two of Chapter 22's scenes reference:

- **Scenario 2 (`/btw`):** Devon folds in the constraint "also append every
  intercept to ~/work/watchdog/escalations.log — don't create a new log file."
  The synthetic log shows the existing append-only shape his fix should match:
  one `[ISO-8601 timestamp] LABEL: detail` line per event.

- **Scenario 4 (`ultrathink`):** the hypothesis prompt asks Claude to read the
  last 200 lines of escalations.log and pin a double-ping root cause. The
  synthetic log is seeded with the tell: two `deploys-monitor` INTERCEPT lines
  with the *same millisecond timestamp* (15:02:11 and again at 17:41:55). That
  duplicate-timestamp pair is the evidence for "orchestrator double-dispatch on
  rapid escalations," which is the answer the chapter's ultrathink prompt
  returns.

## Input shape (for your own real files)

Each line:

    [<ISO-8601 timestamp>] <LABEL>: <detail>

Labels seen in the wild: `INTERCEPT` (a monitor proposed an action),
`APPROVED` / `DENIED` (your decision on a proposal). The orchestrator and
kill-switch in Ch 16/17 write these; nothing in Ch 22 changes the format —
it only reads and (via /btw) appends to it.
