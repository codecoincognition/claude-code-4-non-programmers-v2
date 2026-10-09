# Review of kill-switch.sh — /sandbox + /security-review

Ran ~/work/scripts/kill-switch.sh under /sandbox (OS-level isolation
of the Bash tool):
  Mode tab:      read-write (writes restricted to allowlist)
  Overrides tab: deny  ~/.aws/credentials
                 deny  ~/.ssh/
                 allow ~/work/scratch/
  Config tab:    network: allow localhost; deny external
                 (Slack webhook explicitly allowed)

## Test 1 — normal escalation

PASS. Script generates 4-digit code, appends to escalations.log
(write inside allowlist), posts to Slack webhook (network rule
permitted it).

## Test 2 — malformed input

WARN. Script does not validate input length; passing a 1-byte input
causes the read to time out silently.

Recommend: `[[ -n "$ENTERED" ]]` (and a length check) before comparison.

## Test 3 — missing dependency (osascript not on PATH)

FAIL. Script exits with a cryptic error.

Recommend: check for osascript at start; fall back to `notify-send`
(Linux) or `printf` (any system) if missing.

## Recommendation

Apply both fixes (input length validation + osascript fallback) and
re-run the sandbox before first real use.

## Re-run after fixes

PASS / PASS / PASS. Script is ready for first real use.
