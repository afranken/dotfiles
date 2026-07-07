# mise

| Committed file | Symlinked to                 | Purpose                      |
|----------------|------------------------------|------------------------------|
| `config.toml`  | `~/.config/mise/config.toml` | Global tool/runtime versions |

`apply.sh` runs `mise install` after symlinking, so every runtime declared here is present.

Language servers installed via `mise` and the `Brewfile` are wired into the AI agents — see [../copilot/README.md](../copilot/README.md) and [../claude/README.md](../claude/README.md).
