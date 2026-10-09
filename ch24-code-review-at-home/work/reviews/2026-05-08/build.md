# Review of build.sh — /simplify

## Reuse

- Line 42: the Stripe refresher is invoked by hand. Project
  already has a `run_with_retry` helper in scripts/lib.sh
  that wraps any subcommand with retry + logging. Use it
  instead of the bare call.

## Simplification

- Line 67: hardcoded path `/Users/maya/.npm/bin/vercel`
  will break when Maya changes her npm setup. Replace with
  `command -v vercel` resolution. Same behavior, no path
  fragility.
- Top of file: no `set -euo pipefail`. Adding it removes the
  custom "did the last command succeed?" checks scattered
  through the script — one declaration replaces several
  conditionals.

## Efficiency

- Lines 22-31: the script reads the build manifest twice (once
  for the version stamp, once for the deploy target). One read
  into a local variable would suffice.

## Abstraction level

- The deploy step inline-renders the build URL by concatenating
  strings. The surrounding code uses the `deploy::url` helper.
  Use it here too — the inline version is one altitude lower
  than the rest of the file.

## Applied cleanups

1. set -euo pipefail at top of file.
2. command -v vercel for binary resolution.
3. Replaced inline URL render with deploy::url helper.
4. Hoisted the manifest read into a local variable.
5. Wrapped Stripe refresher in run_with_retry.

(diffs attached at end of file)

## Note

`/simplify` does not look for correctness bugs (as of v2.1.154).
If you want a bug pass on build.sh, run `/code-review` against
the same file.
