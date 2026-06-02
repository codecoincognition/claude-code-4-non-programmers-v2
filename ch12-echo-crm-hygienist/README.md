# Chapter 12 — Echo, the CRM hygienist

Echo is the fourth and final staff member of Part III: a daily **CRM hygienist** that
reads what you actually did this week (outbound Gmail + Calendar) and reconciles it
against what your CRM *says* you did. He proposes the missing entries, the stale stages,
and the cold rows that should be marked — into a daily proposal queue file — and **never
writes to the CRM**. The whole chapter is the read-vs-write asymmetry: the agent that
reads and notices is not the agent that writes. Echo proposes; Maya disposes; Maya's main
Claude session writes, with per-action confirmation. Two locks (Echo's allowlist + the
settings-level deny list) and two separations (proposer vs. writer) keep the system of
record safe.

## File-by-file

- `work/.claude/agents/echo.md` — the Echo subagent. Read-only on Gmail/Calendar/Notion;
  Write/Edit scoped to `~/work/echo/`. Contains the load-bearing **Prospect-evidence
  requirement** (full, not a stub), the deduplication rule, and the "what you never do" list.
- `work/.claude/settings.local.json` — the permissions block. Seven deny rules: the three
  Chapter 0.3 floor rules, the Chapter 9 Gmail-send rule, and three new Echo rules that
  block Notion CRM writes **scoped to the CRM database ID** (`db_crm_8f3a`), so other agents'
  writes to other Notion DBs stay unaffected.
- `work/.claude/memory/echo/` — Echo's between-runs memory:
  - `non-prospects.md` — people Echo has been told never to propose (accountants, vendors,
    personal contacts, recruiters). Read at the top of every run.
  - `discarded.md` — recently discarded proposals; not re-proposed without new evidence.
  - `proposed-log.md` — the audit trail of every proposal and its outcome.
- `work/echo/proposed-2026-05-07.md` — the first-pass proposal queue, in full: 11 missing
  entries, 6 stale stages, 2 cold-without-status. Structured by mismatch category, one
  proposal per item, every item source-anchored.
- `work/scripts/show-brief.sh` — the morning brief script (Chapters 7/9/10/11) with the
  Chapter 12 fifth section, "Echo's proposals," that reads the latest queue file.
- `variants/` — the CRM swap from Step 8:
  - `echo-hubspot.md`, `echo-pipedrive.md`, `echo-salesforce.md` — the same agent body with
    swapped MCP tool names.
  - `deny-list-snippets.md` — matching deny-list block + a substitution table for each CRM.
- `fixtures/` — synthetic stand-ins for Echo's three live inputs (`sent-mail.json`,
  `calendar.json`, `crm.json`) plus a `README.md` explaining each input shape. Real Gmail /
  Calendar / CRM data is never checked in — these let you run `prove-it.sh` offline.
- `prove-it.sh` — runs the four expected reconciliations against the fixtures and asserts:
  Beacon Health fires as missing-entry, Acme Robotics as stale-stage, Sigma Logistics as
  cold-without-status, and Sarah Chen is correctly skipped (non-prospect + no evidence).
- `prompts.md` — every prompt from the chapter, verbatim and in order.

## How to use

1. Drop `work/.claude/agents/echo.md` and the `work/.claude/memory/echo/` files into your
   `~/work/.claude/` tree, and merge the deny block from `settings.local.json` into your own.
2. Confirm your CRM database ID in `CLAUDE.md` and update `db_crm_8f3a` in the deny rules to
   match. (Or swap to a HubSpot / Pipedrive / Salesforce variant from `variants/`.)
3. Run the logic smoke test with no MCPs connected:
   ```bash
   ./prove-it.sh      # requires jq; expects 4 passed, 0 failed
   ```
4. To run Echo for real, dispatch the subagent with the Step 3 prompt from `prompts.md`. He
   reads your last 7 days of Sent + Calendar, cross-references your CRM, and writes
   `~/work/echo/proposed-{date}.md`. He never writes to the CRM.
5. Schedule him at 7 AM weekdays (Step 5 prompt) and add the fifth section to your
   `show-brief.sh`. Approve / edit / discard through your main Claude session — which writes
   to the CRM with per-action confirmation.

The book is self-contained — these files are ready-to-clone copies of what Chapter 12 walks
you through building.
