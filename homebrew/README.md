# homebrew

| Committed file | Symlinked to | Purpose                        |
|----------------|--------------|--------------------------------|
| `Brewfile`     | —            | All packages, casks, and fonts |

The `Brewfile` is the package manifest for the whole machine — formulae, casks, fonts, Mac App Store apps, `cargo` crates, and `npm` globals.

## Adding software

Add the entry to `Brewfile`, then re-run `apply.sh` (or `brew bundle` directly):

```bash
brew bundle --file ~/.dotfiles/homebrew/Brewfile
```
