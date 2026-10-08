# Review of kill-switch.sh — /sandbox + /security-review

Ran ~/work/scripts/kill-switch.sh in an isolated sandbox:
  filesystem: /tmp/sandbox-7f3a/  (mocked ~/work/, ~/.env)
  network:    intercepted (Slack endpoint mocked)
  credentials: stub values

## Test 1 — normal escalation (mock input)

PASS. Script generates 4-digit code, writes to mock escalations.log,
posts to mock Slack endpoint.

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
