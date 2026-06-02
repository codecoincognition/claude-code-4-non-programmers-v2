# Deny-list snippets per CRM

The reader's allowlist on the Echo agent is one lock. The settings-level
deny list is the second lock — it blocks the CRM-write tools for *every*
agent (including the main Claude session, by accident). Add the matching
block to `~/work/.claude/settings.local.json` under `permissions.deny`.

## Notion (the book's default)

```json
"mcp__notion__create_page(database_id=db_crm_8f3a)",
"mcp__notion__update_page(database_id=db_crm_8f3a)",
"mcp__notion__delete_page(database_id=db_crm_8f3a)"
```

Scoped to the CRM database ID so Iris's writes to OTHER Notion databases
(Tasks DB, Project Notes DB) stay unaffected.

## HubSpot

```json
"mcp__hubspot__create_contact",
"mcp__hubspot__update_contact",
"mcp__hubspot__delete_contact"
```

## Pipedrive

```json
"mcp__pipedrive__create_person",
"mcp__pipedrive__update_person",
"mcp__pipedrive__update_deal"
```

## Salesforce

```json
"mcp__salesforce__create_record(sobject=Opportunity)",
"mcp__salesforce__update_record(sobject=Opportunity)",
"mcp__salesforce__create_record(sobject=Lead)"
```

## What changes between variants

In all four cases the BODY of `echo.md` is unchanged — same How-you-work,
same Prospect-evidence requirement, same Deduplication, same Voice, same
What-you-never-do. Only the tool names swap:

| CRM        | Read tools (allowlist)                                  | Write tools (deny list)                            | Vocabulary           |
|------------|---------------------------------------------------------|----------------------------------------------------|----------------------|
| Notion     | query_database, retrieve_page                           | create_page, update_page, delete_page (by DB ID)   | Row, Stage           |
| HubSpot    | search_contacts, get_contact                            | create_contact, update_contact                     | Contact, Deal, Stage |
| Pipedrive  | search_persons, get_person                              | create_person, update_deal                         | Person, Deal, Stage  |
| Salesforce | query_soql, retrieve_record                             | create_record, update_record (sobject=Opportunity) | Lead → Opportunity   |

Four lines in the allowlist, three lines in the deny list, sometimes two
words of vocabulary. That's the whole swap.
