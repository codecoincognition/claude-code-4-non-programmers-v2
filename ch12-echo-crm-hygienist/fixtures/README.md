# Fixtures — synthetic inputs for Echo

Echo reads three live systems through MCP servers: your outbound Gmail,
your Calendar, and your CRM (Notion / HubSpot / Pipedrive / Salesforce).
None of that is checked into the repo — it's your private data, served at
runtime by the MCP servers you connected in Chapter 5.

These fixtures are a tiny synthetic stand-in so you can see the SHAPE of
each input and run `prove-it.sh` without connecting a single MCP. Replace
them with your real systems when you run Echo for real.

## Files

- `sent-mail.json` — shape of the outbound Gmail Echo groups by
  counterparty. One array of threads; each thread has a counterparty,
  subject, timestamp, and a short body excerpt Echo scans for
  prospect-evidence keywords.
- `calendar.json` — shape of the Calendar events Echo reads (organizer =
  Maya only).
- `crm.json` — shape of the Notion CRM rows Echo cross-references against.
  Stage, last contact, owner, status.

## The three mismatch categories these fixtures exercise

1. **Missing entry** — `aria@beaconhealth.example` (Beacon Health) is in
   `sent-mail.json` with pricing + demo evidence, but absent from
   `crm.json`. Echo should propose a new row.
2. **Stale stage** — Acme Robotics is in `crm.json` as "Discovery" but
   `sent-mail.json` shows a contract redline. Echo should propose
   Discovery → Negotiation.
3. **Cold without status** — Sigma Logistics is in `crm.json` as
   "Discovery", last contact 64 days ago, no Lost/Dead status, and has
   zero recent mail. Echo should propose "review for Lost/Dead."
4. **Non-prospect trap** — `sarah@chen-consulting.example` is in
   `sent-mail.json` with 4 threads, but all are W9/tax correspondence
   (no prospect evidence) AND she's listed in `non-prospects.md`. Echo
   should propose NOTHING for her.
