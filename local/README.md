# local

Templates for machine-specific config that must never be committed (secrets, local paths, per-machine aliases).

| Committed template   | Copied to (first run only) | Purpose                          |
|-----------------------|-----------------------------|-----------------------------------|
| `.zshrc-local`        | `~/.zshrc.local`            | Machine-specific shell config and secrets |
| `.aliases-local`      | `~/.aliases.local`          | Machine-specific aliases          |
| `.ssh-config-local`   | `~/.ssh/config.local`       | Machine-specific SSH hosts (hostnames you don't want in a public repo) |

`apply.sh` copies each template to its target the first time it runs. After that, `apply.sh` leaves the target alone — edit these files directly, they're never overwritten or tracked by git.

`shell/zshrc` sources the shell files last, so they win over anything set earlier in `zshrc`. See [`../shell/README.md`](../shell/README.md#machine-specific-overrides). `ssh/config` sources `~/.ssh/config.local` via `Include` — see [`../ssh/README.md`](../ssh/README.md).
