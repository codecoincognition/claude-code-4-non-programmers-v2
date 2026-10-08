# Review of build.sh — /simplify

## Critic findings (3)

1. **No error handling on Stripe refresher.** Line 42:
   `python refresh_stripe.py` runs unguarded; if it fails, the
   script continues and deploys a stale build. Severity: medium.

2. **Hardcoded path to vercel binary.** Line 67:
   `/Users/maya/.npm/bin/vercel` will break when Maya changes
   her npm setup. Severity: low.

3. **No exit code propagation.** The script exits 0 even if
   the deploy step fails. Severity: medium.

## Simplifier proposed fixes

1. Wrap the Stripe refresher in `set -euo pipefail` at the top
   of the script; remove the unguarded run pattern.
2. Replace the hardcoded vercel path with `command -v vercel`
   resolution.
3. Capture the deploy step's exit code and exit with it.

(diffs attached at end of file)

## Verifier check

- Fix 1: PASS. set -euo pipefail is the standard shell pattern;
  no behavior change for the success path.
- Fix 2: PASS. command -v resolves to the same binary on Maya's
  current setup; portable.
- Fix 3: PASS. The exit code propagation is the correct semantic;
  the previous behavior of always exiting 0 was the bug.

## Recommendation

Apply all three fixes.
