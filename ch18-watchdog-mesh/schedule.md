# Scheduling the orchestrator (Step 5)

The orchestrator only runs on demand until you schedule it. The chapter
prompt:

> Schedule the orchestrator to run every 15 minutes during weekdays from
> 7 AM to 11 PM Eastern on this Mac mini. Outside those hours, it should
> be silent. The mesh has to run on my hardware, not in someone else's
> cloud.

Claude installs a local cron entry (macOS uses cron under the hood;
launchd would also work, slightly more verbose) and turns the sentence
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
- Command: `claude -p "run the watchdog-orchestrator one cycle"`
- Cadence: 64 cycles per weekday, silent unless something matters,
  paused overnight and on weekends.

Verify: `crontab -l`
Remove: `crontab -e` and delete the line.

`/schedule` exists, but it runs jobs in Anthropic's cloud. For agents that
must run on your hardware, Claude reaches for cron (macOS/Linux) or Task
Scheduler (Windows) instead.

## Cost note (from "The lift")

A `*/15` schedule with three monitors doing real MCP calls runs 64 times
a day per monitor. If that's too much spend, tier the schedule:
"every 15 min during work hours, every hour overnight." Appendix B has
the spend math.
