---
description: Cancel a leaking subscription via the browser-driven
             cancellation flow (Ch 20). First run in plan mode;
             subsequent runs auto-approved per the tightened threshold.
arguments: provider name (e.g. "acme-streaming")
---

# /cancel-leak

Cancel the subscription for the provider named in $ARGUMENTS using the
browser-driven cancellation flow from Chapter 20.

## Flow

1. Open the provider's account/billing page.
2. Locate the cancellation entry point (often buried behind a
   "manage plan" → "cancel" dark-pattern path).
3. Walk the cancellation flow, declining "we'll miss you" surveys
   and retention offers.
4. Confirm cancellation and capture the confirmation screen.

## Auto-approval threshold (POST-REVIEW — tightened)

After watching the FIRST cancellation in plan mode, auto-approve
subsequent cancellations from the same provider for 30 days
**only when the flow shape matches** — verified by:
  - URL pattern match (same cancellation URL path), AND
  - DOM landmark match (same page structure / form fields).

If the provider's cancellation flow CHANGES shape (new dark pattern,
new redirect, new survey), the URL/DOM match fails and the run drops
back to plan mode so the human watches it again.

> Previous (insecure) threshold was "same provider" only — that
> auto-approved flows the human had never seen. Fixed in Ch 23.

## Credentials

Reference the Stripe key via the environment, never inline:

    $STRIPE_API_KEY        # sourced from ~/.env — never hardcoded here
