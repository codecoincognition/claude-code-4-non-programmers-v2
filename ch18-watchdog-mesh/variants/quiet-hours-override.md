# Variant #2 — Quiet hours override

For the reader who wants 24/7 watching without 24/7 pinging. The
orchestrator keeps running through the night, but between 11 PM and 6 AM
it downgrades `notify` events to `log_only` so you sleep through them.
Only true `escalate` events break through.

## The prompt

> Build a 'quiet hours' override — between 11 PM and 6 AM, the
> orchestrator only escalates at tier escalate; all notify events get
> downgraded to log_only so I sleep through them.

## Add to orchestrator.md

Insert this block into the orchestrator's per-cycle logic, after the
tier-aggregation step:

```markdown
## Quiet hours

If the current local time is between 23:00 and 06:00, apply the quiet-
hours downgrade BEFORE acting on tiers:
  - any monitor returning `notify`  → treat as `log_only`
  - any monitor returning `escalate` → unchanged (still breaks through)
Outside 23:00-06:00, no downgrade.
```

This pairs with running the orchestrator on a 24/7 schedule
(`*/15 * * * *`) instead of the default weekday-daytime
`*/15 7-23 * * 1-5`.
