# git

Multi-identity git setup. Three identities, picked automatically based on where a repo lives — no per-repo config, no manual switching.

| Committed file           | Symlinked to            | Purpose                              |
|--------------------------|-------------------------|--------------------------------------|
| `gitconfig`              | `~/.gitconfig`          | Base git config + `includeIf` routing |
| `gitconfig-personal`     | `~/.gitconfig-personal` | Identity for `~/dev/`                |
| `gitconfig-adobe`        | `~/.gitconfig-adobe`    | Identity for `~/work/adobe/`         |
| `gitconfig-corp`         | `~/.gitconfig-corp`     | Identity for `~/work/corp/`          |

All files are symlinked by `apply.sh` — no editing needed. Identity is selected by the `includeIf "gitdir:…"` rules in `gitconfig`, so simply cloning a repo into the right directory gives it the right name, email, and signing key.

## Identity cheatsheet

| Context      | Directory        | Transport | Host/alias             | gitconfig               |
|--------------|------------------|-----------|------------------------|-------------------------|
| Personal     | `~/dev/`         | SSH       | `github.com`           | `~/.gitconfig-personal` |
| Adobe GitHub | `~/work/adobe/`  | SSH       | `github-adobe`         | `~/.gitconfig-adobe`    |
| Corp GitHub  | `~/work/corp/`   | SSH       | `git.corp.adobe.com`   | `~/.gitconfig-corp`     |

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

Verify each key works:

```bash
ssh -T git@github.com        # should greet your personal account (afranken)
ssh -T github-adobe          # should greet your adobe account (franken_adobe)
ssh -T git@git.corp.adobe.com
```

Switch the dotfiles remote to SSH (push will now use `id_personal` automatically):

```bash
git -C ~/dev/afranken/dotfiles remote set-url origin git@github.com:afranken/dotfiles.git
```

**Cloning adobe org repos**: substitute `github-adobe` for `github.com` so the right key is used:

```bash
# Not this:  git clone git@github.com:adobe/repo.git
git clone git@github-adobe:adobe/repo.git
```

Repos already cloned with the wrong remote can be fixed:

```bash
git remote set-url origin git@github-adobe:adobe/repo.git
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
