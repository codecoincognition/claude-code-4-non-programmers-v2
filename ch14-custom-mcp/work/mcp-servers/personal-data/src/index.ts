// personal-data — a tiny MCP server that reads a CSV of past campaigns
// and exposes three tools: list_records, find_record, summarize_records.
//
// This is the FIXED version (post "When it goes wrong" beat): CSV_PATH
// uses os.homedir() so the ~ expands correctly inside Node, which the
// shell would normally expand but fs.readFile does not.

import os from "os";
import path from "path";
import { readFile } from "fs/promises";
import { parse } from "csv-parse/sync";
import { z } from "zod";

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

// The load-bearing constant. Build the absolute path from the home
// directory — do NOT pass a literal "~" to fs.readFile.
const CSV_PATH = path.join(os.homedir(), "work/data/campaigns.csv");

// Boring helper: read the CSV file, parse it, return rows as objects
// keyed by the header row. Returns [] if the file is missing/empty,
// and logs the loud failure so debugging from the log is possible.
type Row = Record<string, string>;

async function loadCsv(csvPath: string): Promise<Row[]> {
  console.error(`loadCsv called with path: "${csvPath}"`);
  try {
    const raw = await readFile(csvPath, "utf-8");
    const rows = parse(raw, {
      columns: true,
      skip_empty_lines: true,
      trim: true,
    }) as Row[];
    return rows;
  } catch (err) {
    // Loud failure to the log (cause), graceful symptom to the user.
    console.error(`loadCsv failed: ${(err as Error).message}`);
    return [];
  }
}

const server = new McpServer({
  name: "personal-data",
  version: "0.1.0",
});

// Tool 1 — list_records
server.tool(
  "list_records",
  "Return all rows from the campaigns CSV.",
  {}, // no inputs
  async () => {
    const rows = await loadCsv(CSV_PATH);
    if (rows.length === 0) {
      return { content: [{ type: "text", text: "No records found." }] };
    }
    return {
      content: [{ type: "text", text: JSON.stringify(rows, null, 2) }],
    };
  },
);

// Tool 2 — find_record
server.tool(
  "find_record",
  "Look up one campaign by name. Returns the matching row or null.",
  {
    name: z.string().describe("Campaign name to find (case-insensitive)"),
  },
  async ({ name }) => {
    const rows = await loadCsv(CSV_PATH);
    const match = rows.find(
      (r) => (r.name ?? "").toLowerCase() === name.toLowerCase(),
    );
    return {
      content: [
        {
          type: "text",
          text: match ? JSON.stringify(match, null, 2) : "No campaign found.",
        },
      ],
    };
  },
);

// Tool 3 — summarize_records
server.tool(
  "summarize_records",
  "Return count, date range, and a one-line stat across all campaigns.",
  {},
  async () => {
    const rows = await loadCsv(CSV_PATH);
    if (rows.length === 0) {
      return { content: [{ type: "text", text: "No records found." }] };
    }
    const dates = rows.map((r) => r.launched_at).filter(Boolean).sort();
    const winners = rows.filter((r) => r.outcome === "shipped").length;
    const summary =
      `${rows.length} campaigns from ${dates[0]} to ${dates.at(-1)}. ` +
      `${winners} shipped, ${rows.length - winners} cut.`;
    return { content: [{ type: "text", text: summary }] };
  },
);

// Start the server over stdio — how the MCP host talks to it.
const transport = new StdioServerTransport();
await server.connect(transport);
console.error("Server started.");
