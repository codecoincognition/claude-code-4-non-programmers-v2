---
description: Scan for upcoming subscription and contract renewals.
---

Find anything that renews or expires in the next 60 days.

1. Look through `finance/` and `inbox/` for subscriptions, contracts, or recurring charges with a renewal or end date.
2. List each one with: name, amount, renewal date, days until renewal.
3. Sort by soonest first. Flag anything inside 14 days.
4. Write the result to `inbox/renewals-{today's date}.md` and give me the path plus the count of items inside 14 days.
