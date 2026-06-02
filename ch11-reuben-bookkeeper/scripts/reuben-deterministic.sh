#!/usr/bin/env bash
# Reads ~/work/data/transactions.csv and prints exact monthly totals.
# CSV format: date,amount,description,bank_category
# Pure awk arithmetic. No AI.

set -euo pipefail

CSV="${1:-${HOME}/work/data/transactions.csv}"
[[ -f "$CSV" ]] || { echo "Missing: $CSV" >&2; exit 1; }

awk -F',' 'NR > 1 {
    month = substr($1, 1, 7)
    amt   = $2 + 0
    if (amt > 0) { in_m[month] += amt;  in_total  += amt }
    else         { out_m[month] += -amt; out_total += -amt }
    months[month] = 1
}
END {
    printf "Month        Inflow         Outflow        Net           Running\n"
    printf "----------   ------------   ------------   -----------   ------------\n"
    n = asorti(months, m_sorted)
    running = 0
    for (i = 1; i <= n; i++) {
        m = m_sorted[i]
        net = in_m[m] - out_m[m]
        running += net
        printf "%-10s   %12.2f   %12.2f   %11.2f   %12.2f\n",
               m, in_m[m], out_m[m], net, running
    }
    printf "----------   ------------   ------------   -----------\n"
    printf "%-10s   %12.2f   %12.2f   %11.2f\n",
           "TOTAL", in_total, out_total, in_total - out_total
}' "$CSV"
