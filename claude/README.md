# claude

Claude Code configuration.

| Committed file  | Symlinked to                     | Purpose                                      |
|------------------|----------------------------------|-----------------------------------------------|
| `statusline.sh`  | `~/.claude/statusline.sh`        | Claude Code status line                       |
| `lsp-plugin/`    | `~/.claude/skills/dotfiles-lsp`  | Local plugin: LSP servers not in the official marketplace |

## Plugins (via `apply.sh`)

`apply.sh` installs code-intelligence and GitHub plugins (`jdtls-lsp`, `kotlin-lsp`, `rust-analyzer-lsp`, `typescript-lsp`, `pyright-lsp`, `github`).

## `dotfiles-lsp` local plugin

The official `claude-plugins-official` marketplace has no LSP plugin for Terraform, Helm, YAML, or Go (with template support), so `lsp-plugin/` is a local skills-directory plugin (loaded as `dotfiles-lsp@skills-dir`, no marketplace needed) providing `terraform-ls`, `helm-ls`, `yaml-language-server`, and `gopls`. See [copilot/README.md](../copilot/README.md) for why Helm only claims `.tpl` files rather than `.yaml`/`.yml`.

## Enable the status line

`~/.claude/settings.json` isn't managed by dotfiles (it holds machine-specific hooks/plugins), so add this block manually:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh",
  "padding": 2
}
```
