# Deny-list snippets per CRM

The reader's allowlist on the Echo agent is one lock. The settings-level
deny list is the second lock — it blocks the CRM-write tools for *every*
agent (including the main Claude session, by accident). Add the matching
block to `~/work/.claude/settings.local.json` under `permissions.deny`.

## A note on grammar before you copy anything

Per-database and per-object scoping isn't supported in deny-rule grammar
— only `mcp__server`, `mcp__server__*`, and `mcp__server__tool` work.
Argument-level matchers like `(database_id=db_crm_8f3a)` or
`(sobject=Opportunity)` are not part of the supported syntax; they look
like they'd work, but they're silently treated as full tool names that
match nothing and therefore deny nothing.

The honest tradeoff: a deny rule blocks `mcp__notion__create_page`
across *every* Notion database, not just the CRM. If you also use Notion
for the Tasks DB or Project Notes (Iris does, per Chapter 9), those
writes get blocked too. For per-database (or per-object, per-record-type)
enforcement, use a `PreToolUse` hook that inspects the tool call's
arguments and exits 2 if the wrong target is passed. The deny list is
the structural floor; the hook is the operational gate. Together they
implement what the deny grammar alone cannot.

The snippets below are the structural floor only.

## Notion (the book's default)

```json
"mcp__notion__create_page",
"mcp__notion__update_page",
"mcp__notion__delete_page"
```

Blocks Notion writes across every database. To let Iris's writes to the
Tasks DB and Project Notes DB through while keeping the CRM locked, add
a `PreToolUse` hook at `~/work/scripts/notion-write-gate.sh` that reads
the `database_id` from the tool call's JSON payload and exits 0 (allow)
for the Tasks DB and Project Notes DB IDs, exits 2 (deny) for the CRM
database ID. The CRM ID lives in `CLAUDE.md` so it stays portable.

## HubSpot

```json
"mcp__hubspot__create_contact",
"mcp__hubspot__update_contact",
"mcp__hubspot__delete_contact"
```

HubSpot's tool surface is per-object-type already (`create_contact`,
`create_deal`, `create_company`), so the deny list naturally scopes
itself by object type. No per-record gating needed for the common case.

## Pipedrive

```json
"mcp__pipedrive__create_person",
"mcp__pipedrive__update_person",
"mcp__pipedrive__update_deal"
```

Like HubSpot, per-object-type tool names give you object-level scope for
free.

## Salesforce

```json
"mcp__salesforce__create_record",
"mcp__salesforce__update_record"
```

Salesforce is the trickiest case because `create_record` is a single
generic tool that takes the `sobject` as an argument — so the deny rule
blocks writes to *every* object (Lead, Opportunity, Account, Contact,
custom objects, the lot). If you only want to lock Opportunities and
leave Lead-creation open, add a `PreToolUse` hook that inspects the
`sobject` argument and exits 2 only when it equals `Opportunity`.

## What changes between variants

In all four cases the BODY of `echo.md` is unchanged — same How-you-work,
same Prospect-evidence requirement, same Deduplication, same Voice, same
What-you-never-do. Only the tool names swap:

| CRM        | Read tools (allowlist)              | Write tools (deny list)                          | Per-target gating                                |
|------------|-------------------------------------|--------------------------------------------------|--------------------------------------------------|
| Notion     | query_database, retrieve_page       | create_page, update_page, delete_page            | PreToolUse hook reads `database_id`              |
| HubSpot    | search_contacts, get_contact        | create_contact, update_contact, delete_contact   | Tool name already per-object — no hook needed    |
| Pipedrive  | search_persons, get_person          | create_person, update_person, update_deal        | Tool name already per-object — no hook needed    |
| Salesforce | query_soql, retrieve_record         | create_record, update_record                     | PreToolUse hook reads `sobject`                  |

Four lines in the allowlist, three lines in the deny list, sometimes a
small PreToolUse hook to recover the per-target precision the rule
grammar doesn't give you. That's the whole swap.
