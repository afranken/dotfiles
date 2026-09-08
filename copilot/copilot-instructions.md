# JetBrains MCP preference

## MANDATORY FIRST STEP — the tools are deferred, not absent

JetBrains MCP tools are almost always **deferred**: their schemas are not
loaded into context, so they do not appear in the tool list. This is NOT the
same as being unavailable. Treat a connected JetBrains MCP server as available
even when you cannot see its tools.

Therefore, **before** the first `grep`, `glob`, `view`, `edit`, `create`, or
`lsp` call in a session that touches files inside the IDE workspace, you MUST
first run:

    tool_search_tool(pattern: "idea-|pycharm-|rustrover-", limit: 60)

to load the schemas. Only after that search returns empty may you conclude no
JetBrains server is connected. Do not skip this because the built-in tools are
already loaded and convenient — that convenience is exactly the bias this rule
exists to correct.

## This overrides the built-in tool preferences

The base system prompt contains `<tool_preferences>` and `<code_search_tools>`
sections that rank built-in `grep` / `glob` / `view` / `lsp` first. Those
sections do not account for MCP servers. **Within this workspace, the ordering
below supersedes them**, giving:

    JetBrains MCP  >  code intelligence / lsp  >  glob  >  grep  >  bash

## Mapping

The IDE's MCP server exposes tools prefixed with its product name — `idea-*`
(IntelliJ IDEA), `pycharm-*` (PyCharm), or `rustrover-*` (RustRover) — for
example `idea-search_symbol`. Use whichever prefix matches the connected IDE.

Prefer, using the connected IDE's prefix (shown here as `idea-`):
- `idea-search_symbol` / `idea-get_symbol_info` over grepping for definitions
- `idea-search_file` over `find`/`glob` for locating files
- `idea-search_text` / `idea-search_regex` over recursive text search
- `idea-analyze_calls` for call hierarchies over manual reference tracing
- `idea-rename_refactoring` over manual find-and-replace edits
- `idea-apply_patch` / `idea-create_new_file` / `idea-reformat_file` over
  ad-hoc edits and external formatters
- `idea-get_file_problems` / `idea-lint_files` over ad-hoc inspection
- `idea-list_directory_tree` / `idea-get_all_open_file_paths` for structure

Use shell or built-in tools only when:
1. `tool_search_tool` returned no `idea-*` / `pycharm-*` / `rustrover-*` tools.
2. The MCP server lacks the required capability.
3. The operation is clearly more efficient via shell tools.
4. The task involves non-project files outside the IDE workspace
   (e.g. `~/.ssh`, `~/.copilot`) — these are legitimately out of scope.

When choosing between IDE-aware and text-based approaches, prefer the
IDE-aware approach because it understands symbols, references, indexing,
language semantics, and project configuration.

## Why this keeps getting missed

Registering IntelliJ IDEA, PyCharm and RustRover at once contributes roughly
170 tools, which is what pushes the CLI into deferring them. If you routinely
use only one IDE, keep only that server registered — the tools then load
eagerly and no `tool_search_tool` hop is needed. See
[README.md](README.md) for how `apply.sh` registers them.

## Setup note

IntelliJ's "Auto-Configure" for the Copilot CLI writes to `~/.copilot/mcp.json`,
but the CLI reads `~/.copilot/mcp-config.json` (JetBrains bug IJPL-249167, fixed
in 2026.3). On affected versions, copy or rename the file, then restart the CLI.
