# ssh

| Committed file | Symlinked to    | Purpose                         |
|----------------|-----------------|---------------------------------|
| `config`       | `~/.ssh/config` | Per-host identity + key routing |

Maps host aliases and hostnames to the correct `~/.ssh/id_*` key, so the right identity is used automatically based on the clone URL. Plain `github.com` defaults to the Adobe key (most clones are work repos); use the `github-personal` alias for personal-account clones, and `git.corp.adobe.com` for corp.

`config` also `Include`s `~/.ssh/config.local`, a machine-specific file that is never committed — add hosts there when the hostname itself shouldn't be visible in this public repo. See [`../local/README.md`](../local/README.md).

The global `Host *` block sets `AddKeysToAgent yes` and `UseKeychain yes` so key passphrases are read from — and stored in — the macOS login Keychain and survive a reboot. This still needs a one-time `ssh-add --apple-use-keychain` per key to seed the Keychain; see [../git/README.md](../git/README.md#ssh-keys).

Generating and uploading the keys: [../git/README.md](../git/README.md#ssh-keys).
