# Dashboard (Chapter 21)

A static, single-page metrics dashboard that Dana (co-founder) opens every
morning at seven. It shows four interactive charts — revenue trend, pipeline by
stage, weekly active clients, and cash runway — rendered with Chart.js. The data
comes from the nightly export written by the Chapter 21 build into a small JSON
file alongside the page; no backend, no database, no live API calls. The page
refreshes itself once a day: a scheduled job regenerates the JSON at 3:00 AM, and
the page reads the fresh file the next time it loads. Bundle stays under 60 KB so
it opens instantly even on a phone.

**Status:** Live. Deployed, refreshing nightly, read daily.

## Links

- [[decisions/2026-04-18-chartjs-over-d3]] — why Chart.js, not D3
- [[runbooks/daily-refresh]] — how the nightly refresh runs and what to check if it fails
- [[debug-log]] — glitches hit during the build
- [[../../patterns/static-dashboards-over-spas]] — the broader pattern
  (write this entry when you next reach for it)
