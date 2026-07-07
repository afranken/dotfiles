# dotfiles

Infrastructure as Code for a macOS machine. One repo describes the desired state of the whole system — packages, config files, shell, identities, and AI tooling — and a single idempotent `apply.sh` brings any Mac up to that state. Run it once or run it a hundred times: the result is the same.

## Quick start

```bash
mkdir -p ~/dev/afranken
git clone https://github.com/afranken/dotfiles.git ~/dev/afranken/dotfiles
ln -s ~/dev/afranken/dotfiles ~/.dotfiles
cd ~/.dotfiles && ./apply.sh
```

`./apply.sh` is idempotent — it installs everything as checked in and configures the tools, and it's safe to re-run after any error. Full walkthrough (SSH keys, git identities, `gh` auth) is in [New machine setup](#new-machine-setup).

## The stack

Notable tool choices and the reason for each:

- **[Supacode](https://supacode.sh/)** — AI coding across many repos at once, using git worktrees to run parallel agents (even several in one repo).
- **[Ghostty](https://ghostty.org/)** (over iTerm2) — GPU-accelerated terminal. → [`ghostty/`](ghostty/README.md)
- **[Starship](https://starship.rs/)** (over oh-my-zsh) — a fast, shell-agnostic prompt that surfaces language, tool, and version context without shell scripting. → [`shell/`](shell/README.md)
- **[Atuin](https://atuin.sh/)** (over default Zsh history) — searchable, directory-scoped shell history. → [`shell/`](shell/README.md)
- **[Homebrew `Brewfile`](https://docs.brew.sh/Brew-Bundle-and-Brewfile)** — one declarative manifest; `brew bundle` installs and upgrades everything in it in a single pass. → [`homebrew/`](homebrew/README.md)
- **[mise](https://mise.jdx.dev/)** — multi-version runtime manager (Java, Python, …). It also provides the language servers the AI agents use to validate syntax locally, without invoking full compilers. → [`mise/`](mise/README.md)

## What's here

Each folder owns one tool or use-case, with its own `README.md` describing the files inside:

| Folder | Purpose |
|--------|---------|
| [`shell/`](shell/README.md) | Zsh config, Starship prompt, Atuin history |
| [`git/`](git/README.md) | Multi-identity git, SSH keys, `gh` auth |
| [`ssh/`](ssh/README.md) | Per-host SSH identity routing |
| [`ghostty/`](ghostty/README.md) | Ghostty terminal config |
| [`homebrew/`](homebrew/README.md) | `Brewfile` package manifest |
| [`mise/`](mise/README.md) | Dev tool / language runtime versions |
| [`claude/`](claude/README.md) | Claude Code status line and plugins |
| [`copilot/`](copilot/README.md) | GitHub Copilot CLI language servers |
| [`local/`](local/README.md) | Machine-specific, uncommitted overrides |

Everything here is the declared desired state: edit a file, re-run `apply.sh`, and the machine converges to match. Add a new tool as its own folder with a short `README.md`.

---

## New machine setup

### 1. Clone

```bash
mkdir -p ~/dev/afranken
git clone https://github.com/afranken/dotfiles.git ~/dev/afranken/dotfiles
ln -s ~/dev/afranken/dotfiles ~/.dotfiles
```

HTTPS needs no SSH keys or accounts set up yet — the repo is public, so this works with zero auth. On a brand new Mac, this first `git` command triggers the Xcode Command Line Tools installer; click Install, wait for it to finish, then re-run the clone.

The repo lives under `~/dev/` (not directly at `~/.dotfiles`) so that the `includeIf "gitdir:~/dev/"` rule in gitconfig automatically picks up the personal git identity. `~/.dotfiles` is a convenience symlink — all scripts and day-to-day commands work through it.

### 2. Apply

```bash
cd ~/.dotfiles && ./apply.sh
```

Installs Homebrew packages, symlinks all config files, initializes AI tooling, and creates starter local files — converging the machine to the state declared in this repo.

`apply.sh` is idempotent by design. Every run checks current state before acting: already-installed packages are skipped, existing symlinks are left alone, and starter files are only created if missing. So it's safe to run again if it errors out (e.g. Xcode license prompts, App Store sign-in issues, a Homebrew Cellar lock from a concurrent run) — just fix whatever caused the error and re-run `./apply.sh`.

### 3. Git identities, SSH keys & gh auth

Git identity is picked up automatically based on where a repo lives, so the dotfiles repo itself already uses the personal identity — no extra config needed. Generating SSH keys, uploading them per account, and authenticating the `gh` CLI for all three accounts is covered in **[`git/README.md`](git/README.md)**.

### 4. Add secrets and machine config

Anything that should not be committed goes in `~/.zshrc.local`, and machine-specific aliases in `~/.aliases.local`. See [`shell/README.md`](shell/README.md#machine-specific-overrides).

### 5. Enable the Claude Code status line

`~/.claude/settings.json` isn't managed by dotfiles — add the status-line block manually as described in [`claude/README.md`](claude/README.md#enable-the-status-line).

---

## Day-to-day

### Adding software

Edit `homebrew/Brewfile`, then re-run `apply.sh` (or `brew bundle` directly). See [`homebrew/README.md`](homebrew/README.md).

### Updating dotfiles

```bash
cd ~/.dotfiles && git pull && ./apply.sh
```

Pulling and re-running `apply.sh` re-converges the machine to the latest declared state. Idempotent — safe to re-run, existing symlinks and local files are left alone.

### Checking the shell environment

```bash
doctor-shell   # defined in zshrc, shows versions of all key tools
```
