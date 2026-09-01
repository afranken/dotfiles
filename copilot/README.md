# copilot

| Committed file    | Symlinked to                 | Purpose                         |
|-------------------|------------------------------|---------------------------------|
| `lsp-config.json` | `~/.copilot/lsp-config.json` | LSP servers for the Copilot CLI |
| `copilot-instructions.md` | `~/.copilot/copilot-instructions.md` | Custom instructions for the Copilot CLI |

Points the Copilot CLI at the locally installed language servers ([../homebrew/README.md](../homebrew/README.md)) so it can validate syntax without running full compilers.

Includes `terraform-ls`, `yaml-language-server`, and `gopls` (with Go's built-in `.tmpl`/`.gotmpl` template support via `templateExtensions`). `helm-ls` is also installed, but since LSP dispatch here is extension-only (no directory-based rules), it's mapped only to `.tpl` (Helm partials like `_helpers.tpl`) rather than `.yaml`/`.yml`, which stay owned by `yaml-language-server` to keep general YAML validation working everywhere else.
