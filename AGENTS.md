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
  - Running `apply.sh`, `brew bundle`, `mise install`, `claude plugin install`, or any command that installs software or mutates the local machine (including `make apply`).
  - Anything touching credentials, SSH keys, or `gh auth`.

## Conventions

- **Commits**: Conventional Commits — `type: subject`, with types `feat`, `fix`, `chore` (as used in the git history). The body explains *why*; the diff shows *what*.
- **Branches**: short prefixed names mirroring commit types — `feat/…`, `fix/…`, `chore/…`.
- **Docs stay in step with code**: when adding or changing a tool, update that folder's `README.md` and the folder table in the root `README.md` in the same change.

## Known Footguns

### Multi-identity git — `github.com` defaults to the Adobe key
Three git identities are selected purely by clone directory via `includeIf` (git/gitconfig:10-16): `~/dev/` → personal, `~/work/adobe/` → adobe, `~/work/corp/` → corp. Plain `github.com` over SSH resolves to the **Adobe** key because most clones are work repos; personal clones must use the `github-personal` host alias (git/README.md, ssh/README.md). Cloning a personal repo with plain `github.com` gives it the wrong identity and signing key.

### apply.sh partial failures are intentional, not bugs
`brew bundle` failures (e.g. Mac App Store `mas` apps that need interactive sign-in) and plugin/RTK init failures are caught and downgraded to warnings so the rest of setup proceeds (apply.sh:104-113, 145-161). Preserve this — do not "fix" it by making these steps fatal.

### Pinned formula overrides via a local tap
`homebrew/legacy-tap/Formula/*.rb` holds pinned formula overrides (e.g. `zbar` pinned to 0.23.90 — 0.23.93 segfaults on Apple Silicon, Brewfile:28). `apply.sh` materializes these into a local Homebrew tap `local/legacy` (apply.sh:64-73) before `brew bundle`. Edit the `.rb` under `homebrew/legacy-tap/`, never the generated tap copy.

### `~/.claude/settings.json` is not managed here
The Claude Code status-line script is symlinked, but `settings.json` is intentionally left unmanaged (machine-specific hooks/plugins); the status-line block is added manually (claude/README.md).

### mise idiomatic version files only warn
`idiomatic_version_file_enable_tools` makes mise read per-project version files, but its shell hook only *warns* on a missing version — it does not auto-install. Run `mise install` in the project or re-run `apply.sh` to clear the warning (mise/README.md).
