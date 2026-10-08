# Auto-tag — Feature Spec

> Spec for the auto-tag feature. The fact-checker reads this file and
> validates every claim in the launch brief against it, line by line.
> Line numbers in the fact-check report refer to lines in THIS file.

## 1. Overview

Auto-tag automatically categorizes incoming customer messages as they
arrive in the support inbox. It assigns each message one of the
standard support categories (billing, bug, feature-request, how-to,
account, other) so agents no longer triage by hand.

## 2. How it works

The model reads the message body and subject, then assigns the most
likely category with a confidence score. Messages below the
confidence threshold are routed to a human for manual tagging.

- The model was trained on 12 months of historical messages from the
  three beta customers, hand-labeled by their support leads.
- Categories are configurable per workspace; the six defaults above
  ship enabled.

## 3. Performance

- Holdout-set accuracy: 92% on the held-back evaluation set.
- Latency target: 95th-percentile response time of 80ms. (Best-case
  single-message latency in the lab was ~50ms, but 80ms p95 is the
  target customers should expect under load.)
- The classifier runs inline on message ingest; no batch step.

## 4. Beta

- In closed beta with 3 customers for 6 weeks.
- Beta customers reported meaningful triage-time reduction. Exact
  hours-saved figures came from customer interviews, NOT from
  instrumentation — treat any "X hours per day" claim as
  interview-sourced and verify with the PM before publishing.

## 5. Rollout

- General availability: rolls out to ALL customers this Friday.
- No customer action required; auto-tag turns on by default and can
  be disabled per workspace in settings.

## 6. Out of scope (v1)

- No automatic replies. Auto-tag categorizes; it does not respond.
- No sentiment scoring (that's a separate feature, sentiment-tag).
- No custom-category training in the UI yet (configurable via API).
