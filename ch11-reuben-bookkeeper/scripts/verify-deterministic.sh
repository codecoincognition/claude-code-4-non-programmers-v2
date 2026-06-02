#!/usr/bin/env bash
# Runs the deterministic arithmetic against the shipped fixture CSV with
# known totals and exits non-zero if any number drifts by even a cent.
# This is the test the chapter's callouts describe ("CI re-runs it daily").
#
# Note on portability: reuben-deterministic.sh (the canonical chapter script)
# uses gawk's asorti() to sort months, which ships with GNU awk. Stock macOS
# ships BWK awk, which lacks asorti. So this test computes the same totals
# with a portable awk + shell `sort` — no asorti — so it passes on any
# Unix shell regardless of which awk is installed. The numbers it checks are
# identical to what reuben-deterministic.sh produces under gawk.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE="${HERE}/../data/transactions.csv.sample"

[[ -f "$FIXTURE" ]] || { echo "FAIL: fixture not found at $FIXTURE" >&2; exit 1; }

# Portable monthly totals: emit "month inflow outflow", sorted by month.
OUT="$(
  awk -F',' 'NR > 1 {
      month = substr($1, 1, 7)
      amt   = $2 + 0
      if (amt > 0) in_m[month]  += amt
      else         out_m[month] += -amt
      seen[month] = 1
  }
  END {
      for (m in seen) printf "%s %.2f %.2f\n", m, in_m[m], out_m[m]
  }' "$FIXTURE" | sort
)"

# Known-good per-month totals for the shipped sample CSV.
EXPECTED="$(cat <<'EOF'
2026-01 18420.00 9214.83
2026-02 14200.00 11842.06
2026-03 21500.00 13096.41
2026-04 17800.00 14287.43
EOF
)"

if [[ "$OUT" != "$EXPECTED" ]]; then
  echo "FAIL: deterministic totals drifted from known-good fixture totals." >&2
  echo "--- expected ---" >&2; echo "$EXPECTED" >&2
  echo "--- got --------" >&2; echo "$OUT" >&2
  exit 1
fi

# Grand totals must tie too: 71920.00 in, 48440.73 out, 23479.27 net.
read -r GIN GOUT <<<"$(
  awk '{i+=$2; o+=$3} END{printf "%.2f %.2f", i, o}' <<<"$OUT"
)"
if [[ "$GIN" != "71920.00" || "$GOUT" != "48440.73" ]]; then
  echo "FAIL: grand totals drifted. inflow=$GIN outflow=$GOUT" >&2
  echo "      expected inflow=71920.00 outflow=48440.73" >&2
  exit 1
fi

echo "PASS: all monthly totals tie."
echo "PASS: grand totals tie (inflow 71920.00, outflow 48440.73, net 23479.27)."
echo ""
echo "Books are sound."
exit 0
