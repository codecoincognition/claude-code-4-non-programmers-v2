# The first thing your support team stops doing Friday.

> Composed by the editor from the research summary + verified claims.
> Structure follows the researcher's recommendation (customer-story
> lead, anchor on time saved, beta-customer quote in paragraph 3,
> close with a question). Only fact-checker-verified claims are used
> directly. One claim is marked **TK** because the fact-checker
> flagged it unverified — fill it in before publishing.

---

On a Tuesday morning six weeks ago, a support lead at one of our
beta customers opened her inbox and, for the first time in a long
time, didn't reach for the category dropdown. The tickets were
already sorted. Billing here, a bug there, a how-to question
flagged for the docs team. She read them, she didn't triage them.
That was the whole change, and it was the change she'd been waiting
for.

That's what auto-tag does. As messages arrive in your support
inbox, it categorizes incoming customer messages automatically —
billing, bug, feature request, how-to, account — so your agents
stop sorting and start answering. It reads the subject and the body,
assigns the most likely category, and routes anything it's unsure
about to a human. No new step. No new screen. The inbox just
arrives sorted.

We didn't guess at the categories. Auto-tag was trained on 12
months of historical messages from our three beta customers,
hand-labeled by their own support leads — so the categories match
the way real teams actually talk about their tickets, not a generic
taxonomy we invented. On the held-back evaluation set it hit 92%
accuracy. The messages it isn't confident about don't get a wrong
label; they go to a person.

"I stopped thinking about where a ticket goes and started thinking
about the customer who sent it," the support lead told us during
the beta. That's the shift we were after. Auto-tag is supposed to
save customer support teams **TK hours per day** [throughput/
time-saved figure flagged by fact-checker — interview-sourced, not
instrumented; confirm with PM before publishing], but the number
isn't the point. The point is the attention it gives back. When the
inbox sorts itself, the first thing a triage queue does every
morning — the manual pass — just stops happening.

It runs inline, on ingest, fast enough that your agents never wait
for it. [Latency claim trimmed: the brief's "50ms response time"
was flagged unverified against the spec's 80ms p95 target — reworded
to remove the specific number rather than ship a wrong one.]

Auto-tag rolls out to all customers Friday. There's nothing to
install and no action to take — it turns on by default, and any
workspace that wants to keep tagging by hand can switch it off in
settings. The six standard categories ship enabled; you can adjust
them per workspace.

A note on what it doesn't do, because the line matters: auto-tag
categorizes, it doesn't reply. It won't answer your customers and it
won't score sentiment — those are different jobs. What it does is
take the one repetitive decision your team makes hundreds of times a
day and make it disappear.

So here's the question worth asking your team this week: if the
inbox sorted itself every morning, what would you do with the first
hour you got back?
