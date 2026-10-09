# Sunday-night governance hour

One hour, every Sunday evening. Six steps. Tea, not coffee.

1. **Inventory the folder.** Read every CLAUDE.md, command,
   agent, skill, hook. For each, name when it last did
   something useful.

2. **Read the logs.** Watchdog escalation log (group by monitor,
   surface false positives). Cancellation log (anything new
   closed). Dashboard build cron (every night exit 0?).

3. **One fire / keep / rebuild decision.** Pick the least-active
   artifact (or the one that surprised you in the inventory).
   Run the three-question rubric.

4. **Tighten one rubric.** Pick a monitor or hook that misfired
   this week. Diff before saving.

5. **Audit one skill.** Pull three recent pieces. Compare to
   the skill's rules. Update one rule if drift is real.

6. **Review the launch funnel.** Last 7 days of leads-by-source
   from the Notion Leads DB (Ch 20). Conversion-rate trend
   from the dashboard. A/B test status. Is there a campaign
   that drifted from its target?

The hour exists on the calendar even when nothing is wrong.
It is a placeholder for *attention*, not for action.
