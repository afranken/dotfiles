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
| `homebrew/Brewfile`      | —                          | All packages, casks, and fonts       |

Each folder groups files by tool/use-case (`git/`, `shell/`, `ghostty/`, `claude/`, `homebrew/`) — add new use-cases as their own folder.

Local files created by bootstrap (not committed):

| File | Purpose |
|---|---|
| `~/.zshrc.local` | Machine-specific shell config, sourced last |
| `~/.aliases.local` | Machine-specific aliases, sourced last |

---

## New machine setup

### 1. Clone

```bash
git clone https://github.com/afranken/dotfiles.git ~/.dotfiles
```

HTTPS needs no SSH keys or accounts set up yet — the repo is public, so this works with zero auth. On a brand new Mac, this first `git` command triggers the Xcode Command Line Tools installer; click Install, wait for it to finish, then re-run the clone.

Once your SSH keys are set up (step 4) and you want push access, switch the remote:

```bash
git remote set-url origin git@github.com:afranken/dotfiles.git
```

### 2. Bootstrap

```bash
cd ~/.dotfiles && bash bootstrap.sh
```

Installs Homebrew packages, symlinks all config files, and creates starter local files.

### 3. Git identities

Identity is picked up automatically based on where the repo lives (`~/work/adobe/` or `~/work/corp/`).
Both are symlinked from the repo — no editing needed.

If you clone somewhere else, git will warn that no email is set — add a default to `git/gitconfig` if you want a fallback.

### 4. Set up SSH keys

Three keys, one per identity:

```bash
ssh-keygen -t ed25519 -C "coding@techotronic.de" -f ~/.ssh/id_personal
ssh-keygen -t ed25519 -C "franken@adobe.com"     -f ~/.ssh/id_adobe
ssh-keygen -t ed25519 -C "franken@adobe.com"     -f ~/.ssh/id_corp
```

Create `~/.ssh/config`:

```
# Personal GitHub (default)
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_personal

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
pbcopy < ~/.ssh/id_personal.pub   # → github.com (personal account) → Settings > SSH keys
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

```bash
gh auth login --hostname github.com          # run once for personal account
gh auth login --hostname github.com          # run again for adobe account
gh auth login --hostname git.corp.adobe.com  # corp
```

`gh` will prompt for account name each time. Afterwards:

```bash
gh auth status          # see all authenticated accounts
gh auth switch          # interactive account switcher
GH_HOST=git.corp.adobe.com gh pr list   # target a specific host inline
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

| Context | Directory | SSH host | gitconfig |
|---|---|---|---|
| Personal | `~/dev/` | `github.com` | `~/.gitconfig-personal` |
| Adobe GitHub | `~/work/adobe/` | `github-adobe` | `~/.gitconfig-adobe` |
| Corp GitHub | `~/work/corp/` | `git.corp.adobe.com` | `~/.gitconfig-corp` |

Verify which identity a repo is using:

```bash
git config user.email
```
