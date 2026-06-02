# Chapter 19 — The landing page that converts

This chapter builds a webinar-registration landing page as **two layers**: a
visible page (hero, value bullets, social proof, FAQ, two CTAs, mobile-first)
and an invisible conversion stack underneath it — a Vercel serverless
function that validates submissions and writes each lead to a Notion "Leads"
database, meta tags + Open Graph card, a build-time OG image, schema.org
Event/Offer markup, anonymous PostHog analytics, a cookie-based A/B test on
the headline, and a Stop hook that auto-redeploys on edit (with a local
pre-deploy build guard). It deploys to Vercel's free Hobby tier in 77 minutes.

## Files

```
ch19-the-website/
├── README.md                          this file
├── prompts.md                         every chapter prompt, verbatim, in order
├── fixtures/
│   └── README.md                      Notion Leads DB shape + launch-crew inputs
└── work/
    ├── .claude/
    │   └── settings.json              Stop hook: pre-deploy.sh + vercel deploy on edit
    ├── launches/2026-Q3-pricing-webinar/   synthetic Ch 16 launch-crew copy (read source)
    │   ├── headline.md
    │   ├── draft.md
    │   ├── customer-email.md
    │   ├── one-pager.md
    │   └── research.md
    └── site/launch/
        ├── index.html                 visible page + meta/OG/schema (Steps 3 & 6)
        ├── style.css                  mobile-first stylesheet (Step 3)
        ├── script.js                  form handler + PostHog + A/B test (Steps 4,6,8)
        ├── api/
        │   └── submit.ts              the reusable serverless lead-capture function (Step 5)
        ├── og-image-generator.ts      @vercel/og 1200x630 OG image (Step 6)
        ├── package.json               @notionhq/client + @vercel/og
        ├── vercel.json                build config
        ├── leads-schema.md            Notion DB schema doc (Step 5)
        ├── pre-deploy.sh              local build guard rail (Step 10)
        ├── .env.local.example         local-dev env var shape (real secrets go in Vercel)
        └── .gitignore                 keeps .env.local / node_modules / og.png out of git
```

## How to use

1. **Authenticate Vercel once:** `vercel login` (free Hobby tier, no card).
2. **Create the Notion Leads DB** by hand with the schema in
   `leads-schema.md`, connect your Notion integration, copy the 32-char DB ID
   from the URL.
3. **Install + build:** from `work/site/launch/`, run `npm install` then
   `npm run build` (writes `public/og.png`).
4. **Deploy:** `vercel deploy --prod`. In the Vercel dashboard add
   `NOTION_TOKEN` and `NOTION_DB_ID` as environment variables (see
   `.env.local.example` for the shape), then redeploy.
5. **Set your PostHog key:** replace `phc_YOUR_PROJECT_KEY` in `script.js`.
6. **Auto-redeploy:** the `work/.claude/settings.json` Stop hook runs
   `pre-deploy.sh` (local build) then `vercel deploy` whenever you edit
   anything under `site/launch/`. Copy it into your real `~/work/.claude/`.
7. **Test the form** with your real email; confirm a new row in the Notion
   Leads DB.

The serverless function in `api/submit.ts` is the reusable artifact you carry
forward — every future landing page uses a variant of this 40-line file. See
`prompts.md` for the six "make it yours" variations.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 19 walks you through building.
