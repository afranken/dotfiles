# copilot

| Committed file    | Symlinked to                 | Purpose                         |
|-------------------|------------------------------|---------------------------------|
| `lsp-config.json` | `~/.copilot/lsp-config.json` | LSP servers for the Copilot CLI |
| `copilot-instructions.md` | `~/.copilot/copilot-instructions.md` | Custom instructions for the Copilot CLI |

Points the Copilot CLI at the locally installed language servers ([../homebrew/README.md](../homebrew/README.md)) so it can validate syntax without running full compilers.

Also configures local JetBrains MCP server endpoints for IntelliJ IDEA, PyCharm, and RustRover by calling `copilot mcp add` from `apply.sh`. Restart existing Copilot CLI sessions after changing MCP servers so the server list is reloaded.

**Tool-count tradeoff**: each JetBrains server exposes ~58 tools, so registering all three adds ~170. That is enough for the CLI to *defer* them — the schemas are left out of context and the agent must call `tool_search_tool` before it can use them, which in practice means it silently falls back to built-in `grep`/`view`. `copilot-instructions.md` compensates by mandating that search hop. If you only ever use one IDE, drop the other two from `configure_copilot_mcp_servers` in `apply.sh` so the tools load eagerly.

Add internal or non-public MCP servers with the Copilot CLI directly, never in this repo. For example:

```bash
copilot mcp add --transport http internal-tool http://127.0.0.1:12345/stream
```

Includes `terraform-ls`, `yaml-language-server`, and `gopls` (with Go's built-in `.tmpl`/`.gotmpl` template support via `templateExtensions`). `helm-ls` is also installed, but since LSP dispatch here is extension-only (no directory-based rules), it's mapped only to `.tpl` (Helm partials like `_helpers.tpl`) rather than `.yaml`/`.yml`, which stay owned by `yaml-language-server` to keep general YAML validation working everywhere else.
