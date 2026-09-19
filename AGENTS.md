# AGENTS.md — Repository Constraints & Context

> **Read [INVARIANTS.md](INVARIANTS.md) first** — it lists non-negotiable constraints that apply to all work in this repository.

## Repository Overview

Personal macOS dotfiles managed as Infrastructure-as-Code. One repo declares the desired state of a Mac — Homebrew packages, config files, shell, git identities, and AI tooling — and a single idempotent `apply.sh` converges any machine to that state.

There is no build or test suite: the "program" is `apply.sh` plus declarative config files (zsh, TOML, gitconfig, `Brewfile`), each living in a per-tool folder that owns its own `README.md`. See [README.md](README.md) for the human-facing overview and per-folder guide.

## Module Context

No module-level `AGENTS.md` files. Every folder is small (one or a few config files plus a `README.md`); folder-specific detail lives in that folder's `README.md`, and cross-cutting rules are captured here and in [INVARIANTS.md](INVARIANTS.md).

## Agent Authorization

### Contributor (default role for all agents)

- **Authority**: read and edit files; create branches and commit to them; update `README.md`s, `Brewfile`, config files, and `apply.sh`; run read-only and validation commands (`make lint`, `make check`, `shellcheck`).
- **Escalation (requires human sign-off)**:
  - Pushing or merging to `master`.
  - Running `apply.sh`, `brew bundle`, `mise install`, or any command that installs software or mutates the local machine (including `make apply`).
  - Anything touching credentials, SSH keys, or `gh auth`.

## Conventions

- **Commits**: Conventional Commits — `type: subject`, with types `feat`, `fix`, `chore` (as used in the git history). The body explains *why*; the diff shows *what*.
- **Branches**: short prefixed names mirroring commit types — `feat/…`, `fix/…`, `chore/…`.
- **Docs stay in step with code**: when adding or changing a tool, update that folder's `README.md` and the folder table in the root `README.md` in the same change.

## Known Footguns

### Multi-identity git — identity follows the checkout directory
Three git identities are selected by clone directory via `includeIf` (git/gitconfig:10-16): `~/dev/` → personal, `~/work/adobe/` → adobe, `~/work/corp/` → corp. Public GitHub SSH key selection is also directory-based in `ssh/config`: `github.com` uses the personal key from `~/dev` and the Adobe key from `~/work/adobe`, so remotes can stay on canonical `github.com` for IDE pull-request integrations. The `github-personal` host alias is only a fallback for explicit tests or unusual repos outside `~/dev` (git/README.md, ssh/README.md).

### apply.sh partial failures are intentional, not bugs
`brew bundle` failures (e.g. Mac App Store `mas` apps that need interactive sign-in) are caught and downgraded to warnings so the rest of setup proceeds (apply.sh:139-150). Preserve this — do not "fix" it by making these steps fatal.

### mise idiomatic version files only warn
`idiomatic_version_file_enable_tools` makes mise read per-project version files, but its shell hook only *warns* on a missing version — it does not auto-install. Run `mise install` in the project or re-run `apply.sh` to clear the warning (mise/README.md).
