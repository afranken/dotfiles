# mise

| Committed file | Symlinked to                 | Purpose                      |
|----------------|------------------------------|------------------------------|
| `config.toml`  | `~/.config/mise/config.toml` | Global tool/runtime versions |

`apply.sh` runs `mise install` after symlinking, so every runtime declared here is present.

`idiomatic_version_file_enable_tools` makes mise also read per-project version files (`rust-toolchain.toml`, `.bazelversion`, `.node-version`, etc.). Mise's shell activation hook only *warns* when a version from one of these files (or a version added here after the last `apply.sh` run) isn't installed — it does not install it automatically. Run `mise install` inside the project (or re-run `apply.sh`) to clear the warning.

The `rust` tool declares `components = ["rust-analyzer"]`, so `mise install` adds the `rust-analyzer` binary to the mise-managed toolchain via rustup. It resolves through the `~/.cargo/bin/rust-analyzer` shim, which uses the toolchain mise selects (`RUSTUP_TOOLCHAIN`). This is why rust-analyzer is *not* in the `Brewfile`. Caveat: invoking `rust-analyzer` outside the mise environment falls back to rustup's *default* toolchain, which may lack the component and error — anything launched from the mise-activated shell (the AI agents, normal terminals) is unaffected.

Language servers are otherwise installed via the [`Brewfile`](../homebrew/README.md) and wired into the AI agents — see [../copilot/README.md](../copilot/README.md) and [../claude/README.md](../claude/README.md).
