# Regulators to watch

Make-it-yours variation #4 (research scrape, browser-as-data-source). Claude visits
each regulator's recent-rulings page, captures the last 5 rulings as PDFs, and
produces regulators-summary.md (each regulator, ruling dates, headline of each).
Computer use only if a regulator site blocks the browser MCP.

| regulator | recent_rulings_url                                  |
|-----------|-----------------------------------------------------|
| FTC       | https://www.ftc.gov/legal-library/browse/cases-proceedings |
| FDA       | https://www.fda.gov/inspections-compliance-enforcement-and-criminal-investigations/warning-letters |
| SEC       | https://www.sec.gov/litigation/litreleases       |
| FCC       | https://www.fcc.gov/enforcement                  |
| CFPB      | https://www.consumerfinance.gov/enforcement/actions/ |
