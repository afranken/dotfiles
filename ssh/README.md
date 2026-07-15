# ssh

| Committed file | Symlinked to    | Purpose                         |
|----------------|-----------------|---------------------------------|
| `config`       | `~/.ssh/config` | Per-host identity + key routing |

Maps host aliases and hostnames to the correct `~/.ssh/id_*` key, so the right identity is used automatically based on the clone URL. Plain `github.com` defaults to the Adobe key (most clones are work repos); use the `github-personal` alias for personal-account clones, and `git.corp.adobe.com` for corp.

Generating and uploading the keys: [../git/README.md](../git/README.md#ssh-keys).
