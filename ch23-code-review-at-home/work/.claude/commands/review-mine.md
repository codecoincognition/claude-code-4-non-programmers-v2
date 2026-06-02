---
description: Review files I authored — /simplify, /security-review,
             /sandbox, /batch via auto mode. Files at
             ~/work/reviews/{date}/ + a summary.
arguments: optional list of files; defaults to today's modifications
---

# /review-mine

Review the files in $ARGUMENTS, or default to "every file under
~/work/ modified after midnight today."

For each file:
  - Switch on auto mode
  - Let the classifier pick the lens (/simplify, /security-review,
    /sandbox, or some combination)
  - File the per-file review at ~/work/reviews/{today}/{file}.md

After the per-file reviews:
  - File ~/work/reviews/{today}/review-summary.md
  - End with the OK-to-commit signal:
    ✅ if no findings remain
    🚧 if any HIGH or FAIL findings haven't been fixed
    📝 if MEDIUM findings remain (commit allowed but flagged)

If a file is in ~/work/.claude/commands/ — always /security-review
(slash commands grant permissions, not just docs).
If a file is a shell script — first /sandbox, then /security-review.
If a file is in a folder of similar files (≥3 siblings with the
same extension) — propose /batch instead of single-file review.
