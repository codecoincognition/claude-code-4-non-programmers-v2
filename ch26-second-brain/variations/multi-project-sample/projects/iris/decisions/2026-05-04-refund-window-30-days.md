# 2026-05-04 — Refund window is 30 days, no exceptions under $500

**Status:** Accepted
**Project:** [[../README]]

## Context

A customer asked for a refund 41 days after purchase. Iris drafted a reply and
flagged it. This is the third refund-timing question this month and each one was
answered slightly differently, which is a problem.

## Decision

Standard refund window is 30 days. For amounts under $500, no exceptions — the
support cost of case-by-case judgment exceeds the goodwill. Above $500, escalate
to a human (me). Iris drafts the "30-day window has passed" reply and never
auto-approves a refund.

## Consequences

- ✅ Iris now answers refund-timing emails consistently
- ✅ Removes a recurring small decision from my morning
- ❌ Occasionally says no to a sympathetic edge case under $500
- 🔗 Escalation path for >$500 stays human

## Links

- [[../README]] — Iris, the inbox agent
- [[../../patterns/log-approved-replies-as-decisions]] — why this lives here
