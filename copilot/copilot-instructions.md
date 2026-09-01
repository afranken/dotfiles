# JetBrains MCP preference

When JetBrains MCP tools are available in the current session, prefer them
over shell commands for repository navigation, code discovery, refactoring,
symbol lookup, usage search, and code editing.

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

Use shell tools only when:
1. No JetBrains MCP server is connected.
2. The MCP server lacks the required capability.
3. The operation is clearly more efficient via shell tools.
4. The task involves non-project files outside the IDE workspace.

When choosing between IDE-aware and text-based approaches, prefer the
IDE-aware approach because it understands symbols, references, indexing,
language semantics, and project configuration.

## Setup note

IntelliJ's "Auto-Configure" for the Copilot CLI writes to `~/.copilot/mcp.json`,
but the CLI reads `~/.copilot/mcp-config.json` (JetBrains bug IJPL-249167, fixed
in 2026.3). On affected versions, copy or rename the file, then restart the CLI.
