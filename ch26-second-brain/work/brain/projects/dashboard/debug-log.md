# Debug log — dashboard

**Project:** [[README]]

Dated entries. Each one: problem, root cause, fix. Newest at the top.

---

## 2026-04-18 — Charts rendered blank on first deploy

**Problem:** The page loaded, the layout was correct, but all four Chart.js
canvases were empty.

**Root cause:** The page tried to read `data/dashboard.json` before the file
existed — the very first nightly export hadn't run yet, so there was no JSON to
read. Chart.js initialized with `undefined` data and drew nothing.

**Fix:** Generated `data/dashboard.json` once by hand to seed the file, then let
the 3:00 AM job take over. Added a guard so the page shows "data not yet
available" instead of blank canvases when the JSON is missing.

**See:** [[runbooks/daily-refresh]] — the refresh that now produces the file
nightly.
