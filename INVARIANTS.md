# INVARIANTS.md — Hard Constraints

These are non-negotiable. Violations require explicit human sign-off.
`AGENTS.md` links here rather than restating them.

## Security & Secrets

- This is a **public** repository. Never commit secrets, API tokens, private SSH keys, or internal/non-public hostnames. Machine-specific and secret values live only in the git-ignored local files seeded from the `local/` templates — `~/.zshrc.local`, `~/.aliases.local`, `~/.ssh/config.local`. — *Enforced by: human review* (local/README.md, shell/README.md)
- Non-public hostnames go in `~/.ssh/config.local` (pulled in via `Include`, never committed), not in the committed `ssh/config`. — *Enforced by: human review* (ssh/README.md)
- SSH private keys (`~/.ssh/id_personal`, `id_adobe`, `id_corp`) are generated per machine and never committed. — *Enforced by: human review* (git/README.md)

## Idempotency of apply.sh

- `apply.sh` must stay idempotent — safe to run any number of times with the same result. Every operation checks current state first: `brew bundle` skips installed packages, `link_file` leaves already-correct symlinks in place (apply.sh:44-51), and `ensure_local_file` creates local files only when missing (apply.sh:53-62). — *Enforced by: human review*
- `apply.sh` runs under `set -euo pipefail`. Steps that can legitimately fail on a fresh machine (App Store auth, plugin init) must degrade gracefully — warn and continue — rather than abort the run, matching the existing pattern (apply.sh:90-100, 132-137). — *Enforced by: human review*

## File Format

- All committed files use LF line endings — `*.* eol=lf`. — *Enforced by: git (.gitattributes:1)*

## Repository Structure

- Each tool or use-case is one top-level folder holding its config file(s) plus a `README.md` that documents them (README.md:29, 43). New tools follow this pattern. — *Enforced by: human review*
- Committed config files carry no machine-specific absolute paths; they are placed by symlink through `link_file` in `apply.sh` (apply.sh:127-138). Wire up new config by adding a `link_file` line, not by hardcoding paths into the file. — *Enforced by: human review*

## Shell Script Quality

- `apply.sh` and `claude/statusline.sh` must pass `make lint` (shellcheck) before commit. — *Enforced by: `make lint` (shellcheck); no CI configured — run locally*
