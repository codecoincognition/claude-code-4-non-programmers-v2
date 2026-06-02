# Review of cancel-leak.md — /security-review

## HIGH (1)

**Path to gradually-escalating browser-use permissions.** Line 14:

  > "After watching the first cancellation, auto-approve subsequent
  >  cancellations from the same provider for 30 days."

This is the auto-approval threshold. It saves time but creates
a path where:
  - the FIRST cancellation runs in plan mode (Maya watches)
  - the NEXT 29 days of cancellations run unattended

If a provider's cancellation flow CHANGES (a new dark pattern,
a new redirect, a new "we'll miss you" survey), Claude will
auto-approve it because the threshold is "same provider," not
"same flow shape."

Recommended fix: change the threshold to "same provider AND same
flow shape (verified by URL pattern + DOM landmark match — DOM
being the page structure a browser reads)."

## MEDIUM (1)

**Hardcoded API key.** Line 27:

  STRIPE_API_KEY=sk_live_4f8b...

Maya thought she'd parameterized this earlier in the session
but a hardcoded value survived. Move to ~/.env or a secret
store. Reference via $STRIPE_API_KEY.

## LOW (0)

(none)

## Recommendation

Fix HIGH before next use of /cancel-leak. The MEDIUM is a
silent-leak risk if cancel-leak.md ever ends up in version
control.
