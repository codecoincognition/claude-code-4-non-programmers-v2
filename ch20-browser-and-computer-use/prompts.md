# Chapter 20 — every prompt, verbatim and in order

## Cold open (the wish, in Maya's voice)

> Open Chrome. Cancel them. Show me the confirmation pages. File everything. I'm going to make dinner.

## Step 1 — Read the leak file Ch 2 produced

> Read ~/work/finance/subscription-leaks.md (Ch 2 produced this). Tell me what's in it — name, monthly cost, last charge date, cancellation URL — in a table. Then propose the order to cancel them in. Start with the easiest flows; leave the worst dark-pattern sites for last.

## Step 2 — Plan mode for the first cancellation

> Switch to plan mode. Open Chrome. Use my logged-in session if there is one for hulu.com; ask me to log in once if not. Navigate to Hulu's cancellation flow. Walk me through every click before you do it. Capture the final confirmation page as a PDF and file it to ~/work/finance/cancellations/2026-05-08/hulu-confirmation.pdf.

## Step 3 — The auto-approval transition

> I've seen you handle the "we'll miss you" page correctly. For the next six, switch from plan mode to auto-approve, but pause and ask me before any "final confirmation" click. And surface anything weird — anti-automation pages, login prompts, anything that doesn't look like a normal cancellation flow.

## Step 4 — Run the next six

> Go. Cancel the remaining six. File a confirmation PDF for each. When you're done, write summary.md with one entry per cancellation: name, monthly cost recovered, dark patterns navigated, total elapsed time.

## Step 5 — Fall back to computer use for the blocked site

> Adobe blocked the browser MCP. Switch to computer use as a fallback. Open the site in a regular Chrome tab (not the automated one), click through manually using the desktop, capture the same confirmation. Stay in plan mode for this one because computer use is a higher-permission tier than browser use.

## When it goes wrong — the free-month trap (recovery prompt)

> Wait — that's not cancellation, that's a free month. The subscription is still active. Reverse it: open Spotify family again, find where the new "free month" was just applied, cancel it now (real cancel; no extension; no pause). Then update the slash command — for any cancellation flow, the only acceptable terminal state is "subscription will not renew." If a site offers a free month, a pause, a discount, or anything that doesn't end the recurring charge, refuse it and find the real cancel path. If no real cancel path exists, escalate to me before doing anything.

## Step 6 — File the ledger

> Total it up. Write total-saved.md with monthly recovered, annual recovered, and a one-line note: "subscription leak audit complete, 7 of 7 cancelled, terminal state = will not renew." Append a [CANCELLED 2026-05-08] marker to each row in subscription-leaks.md.

## Step 7 — Make-it-yours bridge (browser-as-data-source)

> Different job, same primitives. I have ~/work/research/competitors.csv — 50 SaaS competitors, one per row. For each: visit their pricing page, capture pricing tier names, monthly prices, annual prices, and feature lists. Produce ~/work/research/competitor-pricing/2026-05-08.csv. Use browser use; fall back to computer use only if a site blocks. This is browser-as-data-source, not browser-as-action — no buttons clicked, no state changed.

## Step 8 — Author a slash command for next quarter

> Author ~/work/.claude/commands/cancel-leak.md — takes a leak file path as $ARGUMENTS, walks each subscription in plan mode for the first one, then auto-approves with the final-confirmation guard and the terminal-state clause we just learned. Save my preference: switch from plan mode to auto-approve after the first successful cancellation; the only acceptable terminal state is "subscription will not renew"; refuse any free-month, pause, or discount path and escalate to me.

---

## Make it yours — five variations

### 1. Quarterly subscription audit

> Run the slash command on a fresh `subscription-leaks.md` from this quarter's bank reconciliation. Cancel anything that crept in. Same terminal-state guard.

### 2. Privacy hygiene

> Visit each of the data-broker opt-out sites in `~/work/privacy/data-brokers.md` and submit the opt-out form. File confirmation emails as PDFs. Some forms require typing in a phone number for verification — pause and ask me when that happens.

### 3. Conference RSVP

> Read `~/work/calendar/events-this-month.md`, visit each event's RSVP page, and decline the ones in cities I'm not in. RSVP-yes the ones I am. Pause and ask me on anything that requires a fee.

### 4. Research scrape

> Read `~/work/research/regulators.md`, visit each regulator's recent-rulings page, capture the last 5 rulings as PDFs, and produce a `regulators-summary.md` that lists each regulator, the rulings dates, and the headline of each.

### 5. Cold-list contact harvest

> Read `~/work/crm/cold-list.md`, visit each company's careers page, capture the hiring manager listed for the role I'd target, and produce a contact list at `~/work/crm/contact-list.csv`.

---

## Test yourself in 60 seconds

1. Run my cancel-leak command on ~/work/finance/subscription-leaks.md. Land confirmation PDFs and summary.md in today's dated cancellations folder.
2. Read ~/work/finance/cancellations/{latest}/summary.md and tell me total monthly savings plus any dark patterns Claude logged.
3. This flow needs to fill an iOS native app form. Tell me whether browser use will work and which surface to fall back to.

Stuck? Run "audit my Chapter 20 setup against the chapter spec" — Claude reads your files and tells you what's missing.

---

## The distilled prompt grammar (the lift)

> Use browser use to {action or read} on {site or list of sites}. {Action constraints — what the terminal state is, what to refuse}. Capture {confirmation artifact format}. File to {folder}. If a site blocks browser use, fall back to computer use and tell me. If a site requires a login I haven't done, ask me to log in once and continue.
