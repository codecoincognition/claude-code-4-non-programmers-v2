---
name: cancel-leak
description: >
  Run the quarterly subscription-leak cancellation cycle.
  Reads the leak file passed as $ARGUMENTS (default
  ~/work/finance/subscription-leaks.md), opens Chrome via
  the Claude-in-Chrome MCP, and walks each cancellation flow.
allowed-tools:
  - Read
  - Write
  - mcp__claude-in-chrome
  - mcp__computer-use
---

# Cancel-leak

Read the file at $ARGUMENTS (or ~/work/finance/subscription-leaks.md
if no argument). Format: 4 columns (name, monthly_cost,
last_charge_date, cancellation_url), one row per leak.

## Permission posture

- First cancellation: PLAN MODE. Propose every click; wait for
  approval.
- After the first successful cancellation: switch to AUTO-APPROVE
  with these guards:
  - Pause and ask before any final-confirmation modal.
  - Pause and ask on any anti-automation page (CAPTCHA, "verify
    you're human") and propose computer-use fallback.
  - Pause and ask on any login or password prompt.

## Terminal state — the only acceptable outcome

The only acceptable terminal state is "subscription will not renew."
Refuse any path that ends in a free month, a pause, a discount, a
demoted tier, or any other state that leaves a recurring charge.
If no true-cancel path exists on the site, escalate to the user
before doing anything.

## Output

Per cancellation: confirmation PDF at
~/work/finance/cancellations/{YYYY-MM-DD}/{name}-confirmation.pdf.

End of cycle: write summary.md (one entry per cancellation:
name, monthly cost recovered, dark patterns navigated, terminal
state confirmed, time elapsed) and total-saved.md (monthly,
annual, count cancelled, terminal-state confirmation).

Append [CANCELLED YYYY-MM-DD] markers to the leak file.
