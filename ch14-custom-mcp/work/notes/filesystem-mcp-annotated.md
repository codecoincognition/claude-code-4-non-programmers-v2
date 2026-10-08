# @modelcontextprotocol/server-filesystem — manifest, annotated

_Read-step learning trace. Dated 2026-05-06. Do not maintain — the upstream
package will evolve and this annotation will go stale. The point is "I read
this once with Claude, here is what I learned." Re-annotate when you author
your third MCP._

The package.json (the manifest) declares what this server IS to
anyone who wants to install or run it. Each field, in plain English:

  "name": "@modelcontextprotocol/server-filesystem"
    → The server's identifier. The leading "@modelcontextprotocol/"
       is the npm scope (a namespace, like a folder). The part after
       the slash is the actual name. This is what shows up in
       `claude mcp list` after install.

  "version": "0.6.2"
    → Standard semver (version numbering: major.minor.patch).
       Bumping this is how the maintainers ship
       updates without breaking existing installs.

  "bin": { "mcp-server-filesystem": "dist/index.js" }
    → THE LOAD-BEARING FIELD. "bin" tells npm: when someone installs
       this package, register a command-line tool called
       "mcp-server-filesystem" that runs dist/index.js.
       This is what `claude mcp add` invokes when it starts the
       server. No bin field, no runnable server.

  "main": "dist/index.js"
    → The entry point if another package imports this one as a
       library (rare for MCP servers — most are run, not imported).

  "scripts": { "build": "tsc", "watch": "tsc --watch" }
    → Build commands. "tsc" compiles TypeScript to JavaScript.
       Boring but necessary — the .ts source compiles to dist/.

  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "minimatch": "^10.0.1"
  }
    → Two libraries this server needs. The SDK is the toolkit Anthropic
       publishes — it's what gives you the helper functions for
       declaring tools, reading inputs, returning outputs. minimatch
       is for pattern-matching file paths (a glob library).

  "engines": { "node": ">=18" }
    → Minimum Node.js version. If your Node is older than 18,
       the install will refuse.

---

## One tool handler — `read_file`, annotated

```typescript
// The TOOL DECLARATION — tells the MCP host this tool exists.
server.tool(
  "read_file",
  "Read the complete contents of a file from the filesystem.",
  {
    path: z.string().describe("Path to the file to read"),
  },
  async ({ path }) => {
    //                ↑
    //   This is the INPUT SCHEMA. Claude (the model) reads the
    //   description, the user's request, and the schema, and
    //   constructs an object that matches { path: "..." }
    //   before calling this handler. If the user says "read foo.txt",
    //   Claude builds { path: "foo.txt" } and the handler runs with
    //   that.

    const validPath = await validatePath(path);
    //   ↑
    //   The handler's first move: SANITIZE INPUT. Don't trust the
    //   path Claude built. Make sure it's inside the allowed root.
    //   This is the security seam.

    const content = await fs.readFile(validPath, "utf-8");
    //   ↑
    //   The actual work. One line. Read the file.

    return {
      content: [{ type: "text", text: content }],
    };
    //   ↑
    //   The RETURN SHAPE. Always { content: [...] } where each
    //   item has a type (text, image, etc.) and a payload.
    //   Claude reads this back and uses it in its answer.
  },
);
```

The contract, in three sentences:
  1. The input schema declares what arguments the tool accepts.
  2. The handler does the work. Validate first, do second.
  3. The return shape is always { content: [...] } — Claude reads it.
