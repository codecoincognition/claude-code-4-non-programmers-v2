# Fixtures — external inputs this chapter reads

The landing page writes to **your own Notion** and reads campaign copy from
**your Chapter 16 launch-crew folder**. Those are private to you, so this
companion repo cannot ship the live data. Here is the exact shape of each,
plus tiny synthetic samples so you can wire the chapter end-to-end on your
own account.

---

## 1. The Notion "Leads" database (the write target)

`api/submit.ts` calls `notion.pages.create()` against a database with this
exact property schema. Create it once by hand in Notion (faster than
scripting it), connect it to your Notion integration, and copy the 32-char
database ID from the URL.

| Property      | Notion type | Notes                                  |
|---------------|-------------|----------------------------------------|
| Name          | Title       | required                               |
| Email         | Email       | required                               |
| Company       | Rich text   | required                               |
| Submitted At  | Date        | server timestamp                       |
| Source        | Rich text   | campaign tag, e.g. `pricing-webinar`   |
| Status        | Select      | options: New, Contacted, Registered, Cold |

A single row, after a successful form submit, looks like:

| Name       | Email             | Company | Submitted At         | Source          | Status |
|------------|-------------------|---------|----------------------|-----------------|--------|
| Test Maya  | maya@example.com  | Acme    | 2026-05-12T22:14:00Z | pricing-webinar | New    |

The integration **token** and the **database ID** are secrets. They live in
the Vercel dashboard environment variables (`NOTION_TOKEN`, `NOTION_DB_ID`),
never in a committed file. See `work/site/launch/.env.local.example` for the
local-dev shape.

---

## 2. The launch-crew folder (the read source)

Step 1 points Claude at `~/work/launches/2026-Q3-pricing-webinar/`, which
your Chapter 16 launch crew produced. Synthetic stand-ins ship under
`work/launches/2026-Q3-pricing-webinar/` so the read step works:

| File              | What it provides                          |
|-------------------|-------------------------------------------|
| `headline.md`     | The page H1                               |
| `draft.md`        | Long-form post the page hosts             |
| `customer-email.md` | Voice + tone for the page copy          |
| `one-pager.md`    | Value bullets + objections (FAQ source)   |
| `research.md`     | The 47% stat + source link                |

Replace these with your own Chapter 16 output when you run this for real.
