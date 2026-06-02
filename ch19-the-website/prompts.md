# Chapter 19 — Every prompt, verbatim and in order

These are the exact prompts (and the one CLI command) the chapter has you
run. Copy them in sequence.

---

### Step 0 — Vercel account setup (CLI, one time)

```
vercel login
```

---

### Step 1 — Point Claude at the launch-crew folder; let it interview you

Open Claude in your work folder:

```
cd ~/work && claude
```

First prompt:

> I'm launching a webinar called "Pricing for SaaS founders" next Wednesday. The launch crew already wrote the copy at ~/work/launches/2026-Q3-pricing-webinar/. I need a landing page where people register. Read everything in that folder, then walk me through what you need to know before you build it. Ask me 5 specific questions before drafting anything.

Answers, batched:

> Answers: (1) single CTA — register, no preview PDF. (2) name + email + company. (3) one stat — "47% of SaaS companies mis-price their tier 2 plan", source link in research.md. (4) yes, generate a 4-question FAQ from the objections. (5) Vercel subdomain. Now scaffold ~/work/site/launch/ — propose three layout systems for the hero. Mobile-first.

---

### Step 2 — Pick a layout

> Editorial.

---

### Step 3 — Build the visible page

> Editorial layout. Build the page. Use the headline + value bullets + customer-email copy from ~/work/launches/2026-Q3-pricing-webinar/ so the page voice matches the launch email voice. Mobile-first. Two CTAs (one in hero, one at bottom). 4-question FAQ generated from one-pager.md's objections. Static — no framework, no React, no build step. Show me ~/work/site/launch/index.html in full.

---

### Step 4 — The form JS

> Now the script.js. The form submits to /api/submit. We'll build that serverless function in step 5. For now, write the JS that POSTs to /api/submit and shows a success state on 200, an error message on 400/500, and a "try again" link if the user's network drops mid-submit. No external libraries. ~25 lines of vanilla JS.

---

### Step 5 — The serverless function

> Now build the serverless function at ~/work/site/launch/api/submit.ts. It should: (1) accept POST requests with JSON body {name, email, company}, (2) reject if the honeypot field "website" has any value, (3) validate email regex, name length, all three required fields present, (4) write a row to my Notion "Leads" database — I have a Notion integration token I'll paste once into Vercel's environment variables, and the database ID I'll add too, (5) return JSON {success: true} on 200 or {success: false, message} on validation failure, (6) include CORS headers so the form can call /api/submit from the same domain. Show me the function in full. ~40 lines of TypeScript.

---

### Step 6 — The invisible layer

> Now the invisible layer that makes the page actually rank and look right when shared. (a) Meta tags + OG card so when someone pastes the URL in Slack it shows a real preview. (b) Generate the OG image (1200x630 PNG) at build time from the headline — write a small Node script that uses @vercel/og to render it. (c) Schema.org Event + Offer markup so Google can render rich results. (d) PostHog analytics — track three events: page_view, cta_click, form_submit_success. Use anonymous tracking — no cookies; PostHog has an option for that. Show me the diff to index.html and any new files.

---

### Step 7 — Deploy + env vars

> Deploy ~/work/site/launch/ to Vercel. After the deploy, walk me through adding NOTION_TOKEN and NOTION_DB_ID to the project's environment variables in the Vercel dashboard. Then test the form once with my real email.

---

### Step 8 — A/B test the headline

> Set up an A/B test on the hero headline. Variant A is what we have now. Variant B is "Stop guessing what to charge for tier 2." Cookie-based 50/50 split. Tag every PostHog event with the variant. Don't use any A/B-test SaaS — write the cookie + variant selection in 15 lines of vanilla JS. Important: both headlines must be the same character count to avoid layout shift.

---

### Step 9 — Auto-redeploy on edit

> When I edit any file in ~/work/site/launch/, Vercel should auto-redeploy when my Claude session ends. Update ~/work/.claude/settings.json: add a Stop hook scoped to ~/work/site/launch/** that runs `vercel deploy --prod --yes` and writes the deploy URL to ~/work/site/launch/.last-deploy.log. Show me the diff to settings.json.

---

### Step 10 — When it goes wrong (the near-miss)

> The Vercel deploy succeeded but /api/submit returns INTERNAL_SERVER_ERROR. Check the build log via `vercel inspect`, find the root cause, fix it, redeploy, and verify the form submits successfully end-to-end. Also: add a CI step that runs `npm run build` locally before any vercel deploy, so a missing-dependency bug like this fails fast in my own terminal instead of in production at 10 PM.

---

### Custom domain (optional)

Path A — buy through Vercel:

```
vercel domains buy maya.com
```

---

### Make it yours — five (six) variations

**1. Course-launch waitlist.**

> Run the landing-page flow for a course waitlist. Same shape, but the form is just email; on submit, the serverless function sends a 'You're #N in line' email automatically via the Gmail MCP. Replace the FAQ with a 3-question pre-launch survey. Schema.org type: Course.

**2. Indie-hacker product waitlist.**

> Indie-hacker product waitlist. Same shape, but show a live counter of how many people have already joined; the homepage reads the Notion DB row count and renders it in the hero. Replace social proof with the counter. Replace the FAQ with the product's spec sheet. Schema.org type: SoftwareApplication.

**3. Consulting lead-capture.**

> Consulting lead-capture. Same shape, but embed Calendly below the form; on submit, redirect to Calendly with name + email pre-filled. Replace stat with three customer logos. Schema.org type: Service.

**4. Lead-magnet ebook download.**

> Lead-magnet ebook variant. Same shape, but the form has a hidden field that captures the lead-magnet ID. On submit, the serverless function generates a one-time-use signed S3 URL and emails it via the Gmail MCP. FAQ becomes the book's table of contents. Schema.org type: Book.

**5. A/B test on the second CTA.**

> A/B test on the bottom CTA. The bottom CTA currently says 'Save my seat' (matches the hero). Test variant B = 'Send me the recording.' Same cookie infrastructure as the headline test; tag the events; report which converts higher. Run for three weeks before calling it.

**6. Add a Slack ping on every form submit.**

> Add to api/submit.ts: after the Notion write succeeds, send a Slack message to my #leads channel via the Slack MCP — 'New lead: {name} from {company}'. Include the variant the lead saw.

---

### Test yourself in 60 seconds (chapter end)

1. > Open ~/work/site/launch/api/submit.ts and explain in one sentence what it does — confirm it writes to my Notion Leads DB and returns JSON.
2. > Run pre-deploy.sh and tell me if the build is green. If not, surface the first error.
3. > Identify the five invisible-layer surfaces under my landing page (form-webhook, meta+OG, schema, analytics, A/B test) and confirm each one is wired.

Stuck?

> audit my Chapter 19 setup against the chapter spec
