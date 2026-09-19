# git

Multi-identity git setup. Three identities, picked automatically based on where a repo lives — no per-repo config, no manual switching.

| Committed file       | Symlinked to            | Purpose                               |
|----------------------|-------------------------|---------------------------------------|
| `gitconfig`          | `~/.gitconfig`          | Base git config + `includeIf` routing |
| `gitconfig-personal` | `~/.gitconfig-personal` | Identity for `~/dev/`                 |
| `gitconfig-adobe`    | `~/.gitconfig-adobe`    | Identity for `~/work/adobe/`          |
| `gitconfig-corp`     | `~/.gitconfig-corp`     | Identity for `~/work/corp/`           |

All files are symlinked by `apply.sh` — no editing needed. Identity is selected by the `includeIf "gitdir:…"` rules in `gitconfig`, so simply cloning a repo into the right directory gives it the right name, email, and signing key.

## Identity cheatsheet

| Context      | Directory       | Transport | Host/alias                         | gitconfig               |
|--------------|-----------------|-----------|------------------------------------|-------------------------|
| Personal     | `~/dev/`        | SSH       | `github.com` (`github-personal` ok) | `~/.gitconfig-personal` |
| Adobe GitHub | `~/work/adobe/` | SSH       | `github.com`                       | `~/.gitconfig-adobe`    |
| Corp GitHub  | `~/work/corp/`  | SSH       | `git.corp.adobe.com`               | `~/.gitconfig-corp`     |

Verify which identity a repo is using:

```bash
git config user.email
```

The dotfiles repo itself lives under `~/dev/afranken/dotfiles`, so it gets the personal identity automatically.

## SSH keys

Three keys, one per identity (`~/.ssh/config` is managed by dotfiles — no manual editing):

```bash
ssh-keygen -t ed25519 -C "coding@techotronic.de" -f ~/.ssh/id_personal
ssh-keygen -t ed25519 -C "franken@adobe.com"     -f ~/.ssh/id_adobe
ssh-keygen -t ed25519 -C "franken@adobe.com"     -f ~/.ssh/id_corp
```

Upload each public key to the matching account:

```bash
pbcopy < ~/.ssh/id_personal.pub   # → github.com (personal account) → Settings > SSH keys
pbcopy < ~/.ssh/id_adobe.pub      # → github.com (adobe account)    → Settings > SSH keys
pbcopy < ~/.ssh/id_corp.pub       # → git.corp.adobe.com            → Settings > SSH keys
```

**Store the passphrases in the macOS Keychain (once per machine)**: `~/.ssh/config` sets `UseKeychain yes` + `AddKeysToAgent yes`, but the passphrase has to be handed to the Keychain once. Without this you are prompted again after every reboot:

```bash
ssh-add --apple-use-keychain ~/.ssh/id_personal ~/.ssh/id_adobe ~/.ssh/id_corp
ssh-add -l   # should list all three
```

Verify each key works from a repo or parent directory in the matching tree:

```bash
cd ~/dev && ssh -T git@github.com           # should greet your personal account (afranken)
cd ~/work/adobe && ssh -T git@github.com    # should greet your adobe account (franken_adobe)
ssh -T git@github-personal                  # explicit personal fallback alias
ssh -T git@git.corp.adobe.com
```

Switch the dotfiles remote to the canonical GitHub host (push will now use `id_personal` automatically because the repo lives under `~/dev`):

```bash
git -C ~/dev/afranken/dotfiles remote set-url origin git@github.com:afranken/dotfiles.git
```

**Cloning personal repos**: use the normal `github.com` SSH URL from inside `~/dev`; `~/.ssh/config` chooses `id_personal` based on the current directory. Keeping the remote on `github.com` also keeps IntelliJ IDEA's GitHub pull-request integration happy:

```bash
cd ~/dev
git clone git@github.com:afranken/repo.git
```

Repos already using the old alias can be changed back to the canonical host:

```bash
git remote set-url origin git@github.com:afranken/repo.git
```

## Authenticate the gh CLI (three accounts)

Run `gh auth login` once per account. When prompted for an SSH key, pick the matching key:

```bash
gh auth login --hostname github.com --git-protocol ssh
# → browser opens → sign in as personal account (afranken)
# → when asked which SSH key to use → pick ~/.ssh/id_personal.pub

gh auth login --hostname github.com --git-protocol ssh
# → browser opens → sign in as adobe account (franken_adobe)
# → when asked which SSH key to use → pick ~/.ssh/id_adobe.pub

gh auth login --hostname git.corp.adobe.com --git-protocol ssh
# → sign in as corp account
# → when asked which SSH key to use → pick ~/.ssh/id_corp.pub
```

```bash
gh auth status          # see all authenticated accounts
gh auth switch          # interactive account switcher
GH_HOST=git.corp.adobe.com gh pr list   # target a specific host inline
```
