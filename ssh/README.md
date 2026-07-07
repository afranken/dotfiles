# ssh

| Committed file | Symlinked to    | Purpose                         |
|----------------|-----------------|---------------------------------|
| `config`       | `~/.ssh/config` | Per-host identity + key routing |

Maps host aliases (e.g. `github-adobe`) and hostnames to the correct `~/.ssh/id_*` key, so the right identity is used automatically based on the clone URL.

Generating and uploading the keys: [../git/README.md](../git/README.md#ssh-keys).
