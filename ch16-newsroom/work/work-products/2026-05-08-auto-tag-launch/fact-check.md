## Claims extracted from brief, checked against spec

  ✓ verified  | "categorizes incoming customer messages"
              | source: spec line 4
  ✓ verified  | "trained on 12 months of historical messages"
              | source: spec line 18
  ✓ verified  | "92% accuracy on the holdout set"
              | source: spec line 47
  ✓ verified  | "rolls out to all customers Friday"
              | source: spec line 71

  ✗ UNVERIFIED| "50ms response time"
              | spec says 95th percentile latency target = 80ms.
              | The 50ms claim appears to be best-case, not typical.
              | RECOMMEND: reword to "under 100ms" OR cut.

  ? UNKNOWN   | "saves customer support teams 3 hours per day"
              | not in the spec. could be from the beta customer
              | interviews; verify with PM before shipping.
