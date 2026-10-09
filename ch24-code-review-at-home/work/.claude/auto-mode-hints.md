# Auto-mode classifier hints

Rules read at session start. Override the default classifier.

## Location-based rules (load-bearing)

- ~/work/.claude/commands/*.md       → /security-review (always)
                                       Slash commands grant permissions;
                                       location > content for classification.

- ~/work/scripts/*.sh                → /sandbox (first), then /security-review
- Codebase-wide sweeps (≥5 units,
  each warranting its own PR)        → /batch (require git repo)

## Pattern-based rules

- Files containing "API_KEY=" or "SECRET=" assignments → /security-review HIGH
- Files importing from auth/* or session/*           → /security-review HIGH
