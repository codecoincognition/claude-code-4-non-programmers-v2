# Q3 Board Deck — Brief (source of truth)

This file is the canonical record of intent for the Q3 board deck.
Every later prompt in the session references this file instead of
re-explaining intent. It is the file the boss would write if she
had to write it.

---

## 1. The boss's email (verbatim)

> Subject: Tomorrow's board prep — can you?
>
> Investors want a 10-minute walkthrough of where Q3 landed, what's
> coming in Q4, and the two competitive moves we're worried about.
> I've started a Notion page with my rough thoughts. The deck
> template is in the shared drive. Same format as the May board
> deck. Tomorrow 9 AM.

---

## 2. The Notion bullets (verbatim, ~320 words)

(Source: Notion page "Q3 board prep — rough thoughts", linked in the email.)

- Open with a quick reset on where we are — keep it calm.
- Q3 came in above plan. Want to lead with that, but be honest
  about September going flat.
- Margin held. The September dip is a one-time refund cluster, not
  a trend — say that explicitly so nobody reads it as erosion.
- Net adds are tracking plan. Churn was a tick high in August — we
  had an outage, we owned it, the customers we lost were on the
  fence anyway. Don't bury it.
- Q4 is three workstreams. Two we've committed to. One is
  contingent on the pricing test.
- The pricing test soft-launched in early Q4. Reading two more
  weeks of data before we generalize. Mentioned twice — it matters
  to me. Give it its own moment.
- Competitive: CompetitorX raised, CompetitorY changed pricing.
  Neither changes our plan. Both change how we talk about it.
- The customer-onboarding workstream — the team committed to a
  date and an owner at the last all-hands. Use the specific
  commitment, not the generic roadmap line.
- Risks: three things would make us re-cut the plan. List them
  plainly. The board respects a team that names its own risks.
- Close warm. Happy to go deeper on any of it in Q&A.

---

## 3. My answers to the 5 clarifying questions

1. **Comparison frame:** Q3 vs plan, not vs Q2. (Changes 3 chart slides.)
2. **Pricing:** gets one slide of its own.
3. **Competitive:** the two Atlas-flagged signals are correct — use them.
4. **Two-column master:** yes, use it for the competitive-moves slide.
5. **Length:** target 12 slides total, including title and thank-you.

---

## 4. Source pointers (where each fact will come from)

| Fact | Source |
|------|--------|
| Q3 revenue actual vs plan | `~/work/finance/2026-Q3/bank-export.csv` (revenue rows) + `q4-roadmap.md` header (plan) |
| Gross margin trend | `~/work/finance/2026-Q3/stripe-export.csv` (fees) + `bank-export.csv` (COGS) |
| Net adds vs churn | `~/work/finance/2026-Q3/stripe-export.csv` (subscription events) |
| August churn / outage | Atlas signal 2026-08-12 (incident) + Notion bullet 4 |
| Q4 plan / workstreams | `~/work/strategy/q4-roadmap.md` (H2 sections) |
| Competitive moves | `~/work/atlas/signals-2026-05-08.md` signals #4 and #2 |
| Pricing test | Notion bullet 7 |
| Onboarding commitment | `~/work/strategy/all-hands-2026-05-02.md` |
| Risks | `q4-roadmap.md` (risks section) + Notion bullet 9 |

---

## 5. Open items

(Things still unsure about — currently empty.)
