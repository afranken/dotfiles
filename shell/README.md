# shell

| Committed file  | Symlinked to                  | Purpose                          |
|-----------------|-------------------------------|----------------------------------|
| `zshrc`         | `~/.zshrc`                    | Shell config, aliases, functions |
| `starship.toml` | `~/.config/starship.toml`     | Prompt config                    |
| `atuin.toml`    | `~/.config/atuin/config.toml` | Shell history config             |

## Machine-specific overrides

`apply.sh` creates two files (not committed), sourced last so they win over `zshrc`:

| File               | Purpose                                   |
|--------------------|-------------------------------------------|
| `~/.zshrc.local`   | Machine-specific shell config and secrets |
| `~/.aliases.local` | Machine-specific aliases                  |

Secrets and anything else that must not be committed go in `~/.zshrc.local`:

```bash
export HOMEBREW_GITHUB_API_TOKEN="..."
export AWS_PROFILE="default"
export KUBECONFIG="~/.kube/config"
```

## Health check

```bash
doctor-shell   # shows versions of all key tools
```
