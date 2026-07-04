# dotfiles

Personal macOS dotfiles. Plain Zsh + Starship — no frameworks, no magic.

## What's here

| Committed file           | Symlinked to               | Purpose                              |
|--------------------------|----------------------------|--------------------------------------|
| `shell/zshrc`            | `~/.zshrc`                 | Shell config, aliases, functions     |
| `shell/starship.toml`    | `~/.config/starship.toml`  | Shell prompt config                  |
| `git/gitconfig`          | `~/.gitconfig`             | Git config with multi-identity setup |
| `git/gitconfig-personal` | `~/.gitconfig-personal`    | Git identity for `~/dev/`            |
| `git/gitconfig-adobe`    | `~/.gitconfig-adobe`       | Git identity for `~/work/adobe/`     |
| `git/gitconfig-corp`     | `~/.gitconfig-corp`        | Git identity for `~/work/corp/`      |
| `ghostty/config`         | `~/.config/ghostty/config` | Ghostty terminal config              |
| `claude/statusline.sh`   | `~/.claude/statusline.sh`  | Claude Code status line              |
| `shell/atuin.toml`       | `~/.config/atuin/config.toml` | Atuin shell history config        |
| `copilot/lsp-config.json` | `~/.copilot/lsp-config.json` | LSP servers for GitHub Copilot CLI |
| `homebrew/Brewfile`      | —                          | All packages, casks, and fonts       |

Each folder groups files by tool/use-case (`git/`, `shell/`, `ghostty/`, `claude/`, `copilot/`, `homebrew/`) — add new use-cases as their own folder.

Local files created by bootstrap (not committed):

| File | Purpose |
|---|---|
| `~/.zshrc.local` | Machine-specific shell config, sourced last |
| `~/.aliases.local` | Machine-specific aliases, sourced last |

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

### 2. Bootstrap

```bash
cd ~/.dotfiles && bash bootstrap.sh
```

Installs Homebrew packages, symlinks all config files, and creates starter local files.

The script is idempotent — safe to run again if it errors out (e.g. Xcode license prompts, App Store sign-in issues, a Homebrew Cellar lock from a concurrent run). It skips already-installed packages and existing symlinks, so just fix whatever caused the error and re-run `bash bootstrap.sh`.

### 3. Git identities

Identity is picked up automatically based on where the repo lives. The dotfiles repo itself lives under `~/dev/afranken/dotfiles`, so it gets the personal identity automatically — no extra config needed.

Work repos in `~/work/adobe/` or `~/work/corp/` get their respective identities. All identity files are symlinked from the repo — no editing needed.

### 4. Set up SSH keys (Adobe + corp only)

Personal uses HTTPS (see step 5) — no key needed. Adobe enforces SSH for both GHEC (`github.com`) and corp, so those two still need keys:

```bash
ssh-keygen -t ed25519 -C "franken@adobe.com" -f ~/.ssh/id_adobe
ssh-keygen -t ed25519 -C "franken@adobe.com" -f ~/.ssh/id_corp
```

Create `~/.ssh/config`:

```
# Adobe GitHub (use alias "github-adobe" when cloning adobe org repos)
Host github-adobe
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_adobe

# Adobe internal GitHub
Host git.corp.adobe.com
    HostName git.corp.adobe.com
    User git
    IdentityFile ~/.ssh/id_corp
```

Upload public keys to each account:

```bash
pbcopy < ~/.ssh/id_adobe.pub      # → github.com (adobe account)    → Settings > SSH keys
pbcopy < ~/.ssh/id_corp.pub       # → git.corp.adobe.com             → Settings > SSH keys
```

**Cloning adobe org repos**: substitute `github-adobe` for `github.com` in the clone URL so the right key is used:

```bash
# Not this:  git clone git@github.com:adobe/repo.git
git clone git@github-adobe:adobe/repo.git
```

Repos already cloned with the wrong remote can be fixed:

```bash
git remote set-url origin git@github-adobe:adobe/repo.git
```

### 5. Authenticate gh CLI (three accounts)

Personal uses HTTPS (no SSH key, no alias needed — it's the only account on plain `github.com`); Adobe and corp already authenticate via the SSH keys from step 4:

```bash
gh auth login --hostname github.com --git-protocol https  # personal account
gh auth login --hostname github.com                        # adobe account
gh auth login --hostname git.corp.adobe.com                # corp
```

`gh` will prompt for account name each time. Afterwards:

```bash
gh auth status          # see all authenticated accounts
gh auth switch          # interactive account switcher
GH_HOST=git.corp.adobe.com gh pr list   # target a specific host inline
```

Personal repos clone over plain HTTPS, no alias needed:

```bash
git clone https://github.com/you/repo.git
```

### 6. Add secrets and machine config

Anything that should not be committed goes in `~/.zshrc.local`:

```bash
export HOMEBREW_GITHUB_API_TOKEN="..."
export AWS_PROFILE="default"
export KUBECONFIG="~/.kube/config"
# Artifactory mirrors, vault URLs, etc.
```

Machine-specific aliases go in `~/.aliases.local`.

### 7. Enable the Claude Code status line

`~/.claude/settings.json` isn't managed by dotfiles (it holds machine-specific hooks/plugins), so add this block manually:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh",
  "padding": 2
}
```

---

## Day-to-day

### Adding software

Edit `homebrew/Brewfile`, then:

```bash
brew bundle --file ~/.dotfiles/homebrew/Brewfile
```

### Updating dotfiles

```bash
cd ~/.dotfiles && git pull && bash bootstrap.sh
```

Bootstrap is idempotent — safe to re-run, existing symlinks and local files are left alone.

### Checking the shell environment

```bash
doctor-shell   # defined in zshrc, shows versions of all key tools
```

---

## Three-identity git cheatsheet

| Context | Directory | Transport | Host/alias | gitconfig |
|---|---|---|---|---|
| Personal | `~/dev/` | HTTPS | `github.com` | `~/.gitconfig-personal` |
| Adobe GitHub | `~/work/adobe/` | SSH | `github-adobe` | `~/.gitconfig-adobe` |
| Corp GitHub | `~/work/corp/` | SSH | `git.corp.adobe.com` | `~/.gitconfig-corp` |

Verify which identity a repo is using:

```bash
git config user.email
```
