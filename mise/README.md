# mise

| Committed file | Symlinked to                 | Purpose                      |
|----------------|------------------------------|------------------------------|
| `config.toml`  | `~/.config/mise/config.toml` | Global tool/runtime versions |

`apply.sh` runs `mise install` after symlinking, so every runtime declared here is present.

`idiomatic_version_file_enable_tools` makes mise also read per-project version files (`rust-toolchain.toml`, `.bazelversion`, `.node-version`, etc.). Mise's shell activation hook only *warns* when a version from one of these files (or a version added here after the last `apply.sh` run) isn't installed — it does not install it automatically. Run `mise install` inside the project (or re-run `apply.sh`) to clear the warning.

Language servers are installed via the [`Brewfile`](../homebrew/README.md) and wired into the AI agents — see [../copilot/README.md](../copilot/README.md) and [../claude/README.md](../claude/README.md).
