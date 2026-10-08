# Scheduling the orchestrator (Step 5)

The orchestrator only runs on demand until you schedule it. The chapter
prompt:

> Schedule the orchestrator to run every 15 minutes during weekdays from
> 7 AM to 11 PM Eastern. Outside those hours, it should be silent.

Claude picks the `/schedule` command underneath and turns the sentence
into a cron expression:

```
*/15 7-23 * * 1-5
```

| Field        | Value     | Meaning                          |
|--------------|-----------|----------------------------------|
| minute       | `*/15`    | every 15 minutes                 |
| hour         | `7-23`    | 7 AM through 11 PM               |
| day-of-month | `*`       | every day                        |
| month        | `*`       | every month                      |
| day-of-week  | `1-5`     | Monday through Friday            |

- Working directory: `~/work/worktrees/watchdog-mesh/`
- Cadence: 64 cycles per weekday, silent unless something matters,
  paused overnight and on weekends.
- Job id (example): `cron_watchdog_a31f`

Manage it in natural language:

> list scheduled jobs

> cancel job cron_watchdog_a31f

## Cost note (from "The lift")

A `*/15` schedule with three monitors doing real MCP calls runs 64 times
a day per monitor. If that's too much spend, tier the schedule:
"every 15 min during work hours, every hour overnight." Appendix B has
the spend math.
