# Review summary — 2026-05-08

## Files reviewed (3) + batch (6)

| File | Lens | Findings | Fixed | Outstanding |
|---|---|---|---|---|
| build.sh | /simplify | 3 (med, low, med) | 3 | 0 |
| cancel-leak.md | /security-review | 1 HIGH, 1 MED | 2 | 0 |
| kill-switch.sh | /sandbox+/sec-review | 2 (warn, fail) | 2 | 0 |
| 6 refreshers | /batch | 6 same-pattern | 6 | 0 |

## What was found

The HIGH finding (auto-approval threshold in cancel-leak.md) was
the load-bearing one. It silently widened the surface where Claude
could act unattended on Maya's behalf. The fix narrows the threshold
to URL + DOM landmark match.

The /sandbox findings on kill-switch.sh would have produced an
unhelpful runtime error on first real use; better to discover them
in isolation.

The /batch run extended the build.sh pattern across six refreshers
that would have benefited from the same posture.

## OK to commit

✅ All findings have proposed fixes verified by the pipeline.
   Nothing outstanding. Safe to commit.
