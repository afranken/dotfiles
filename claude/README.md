# claude

Claude Code configuration.

| Committed file | Symlinked to              | Purpose                 |
|----------------|---------------------------|-------------------------|
| `statusline.sh`| `~/.claude/statusline.sh` | Claude Code status line |

## Plugins & RTK (via `apply.sh`)

`apply.sh` installs code-intelligence and GitHub plugins (`jdtls-lsp`, `kotlin-lsp`, `rust-analyzer-lsp`, `typescript-lsp`, `pyright-lsp`, `github`) and initializes the [RTK](https://www.rtk-ai.app/) token-saving proxy globally. Telemetry is disabled via `RTK_TELEMETRY_DISABLED=1` (set in `shell/zshrc`).

## Enable the status line

`~/.claude/settings.json` isn't managed by dotfiles (it holds machine-specific hooks/plugins), so add this block manually:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh",
  "padding": 2
}
```
