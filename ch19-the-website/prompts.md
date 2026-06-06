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

> Write the form-submit JavaScript — when the form is submitted, send it to /api/submit, show a success message if it worked, an error message if it didn't, and a "try again" link if their internet dropped. Keep it tiny. No libraries.

---

### Step 5 — The serverless function

> Build the backend bit that catches the form. It should: take the name/email/company from the form, ignore submissions where the hidden spam-trap field has anything in it, check the email looks real and all three fields are there, write a row to my Notion Leads database (I'll paste the token into Vercel's settings), say success or fail, and let the form on my page call it without being blocked. Show me the whole thing.

---

### Step 6 — The invisible layer

> Now the invisible stuff that makes the page show up well when shared and rank in Google. (a) The little preview that pops up when someone pastes the link in Slack. (b) Auto-make the preview image from the headline. (c) The hidden tags Google uses to know this is an event with a price (so it shows up nicely in search results). (d) PostHog for analytics — cookie-free — tracking page views, button clicks, and successful sign-ups. Show me the diff to index.html and any new files.

---

### Step 7 — Deploy + env vars

> Deploy ~/work/site/launch/ to Vercel. After the deploy, walk me through adding NOTION_TOKEN and NOTION_DB_ID to the project's environment variables in the Vercel dashboard. Then test the form once with my real email.

---

### Step 8 — A/B test the headline

> Set up an A/B test on the hero headline. Variant A is what we have now. Variant B is "Stop guessing what to charge for tier 2." Half the visitors see A, half see B — use a cookie to pin which one each person sees so they don't flip-flop. Tag every PostHog event with which version they saw. No third-party A/B-test tool. Keep the cookie-and-pick code tiny. Important: both headlines must be the same character count to avoid layout shift.

---

### Step 9 — Auto-redeploy on edit

> When I edit any file inside ~/work/site/launch/, Vercel should auto-redeploy when my Claude session ends. Update ~/work/.claude/settings.json: add a Stop hook scoped to anything I change in that folder, that runs the Vercel production deploy and writes the deploy URL to ~/work/site/launch/.last-deploy.log. Show me the diff to settings.json.

---

### Step 10 — When it goes wrong (the near-miss)

> My Vercel deploy went green but the form's submit endpoint is throwing a server error. Read the build log (`vercel inspect`), find what broke, fix it, and verify the form goes through. Also: make sure the same kind of missing-package bug catches locally next time — before it hits production at 10 PM.

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
