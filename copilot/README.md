# copilot

| Committed file    | Symlinked to                 | Purpose                         |
|-------------------|------------------------------|---------------------------------|
| `lsp-config.json` | `~/.copilot/lsp-config.json` | LSP servers for the Copilot CLI |

Points the Copilot CLI at the locally installed language servers ([../mise/README.md](../mise/README.md)) so it can validate syntax without running full compilers.

`apply.sh` also initializes the [RTK](https://www.rtk-ai.app/) proxy for the Copilot CLI (telemetry off via `RTK_TELEMETRY_DISABLED=1` in `shell/zshrc`).
