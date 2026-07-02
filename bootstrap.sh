#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

if [[ "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" != "$DOTFILES_DIR" ]]; then
  DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

backup_file() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local backup="$target.backup.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up $target -> $backup"
    mv "$target" "$backup"
  fi
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then return; fi
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

load_brew_env() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

link_file() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "  Already linked: $target"
    return
  fi
  backup_file "$target"
  ln -s "$source" "$target"
  echo "  Linked $target -> $source"
}

ensure_local_file() {
  local example="$1"
  local target="$2"
  if [[ ! -f "$target" ]]; then
    cp "$example" "$target"
    echo "  Created $target (edit with your details)"
  else
    echo "  Exists:  $target"
  fi
}

ensure_homebrew
load_brew_env

if ! command -v brew >/dev/null 2>&1; then
  echo "brew still not available. Open a new terminal and rerun bootstrap.sh."
  exit 1
fi

echo "→ Installing packages..."
brew bundle --file "$DOTFILES_DIR/homebrew/Brewfile"

echo "→ Linking dotfiles..."
link_file "$DOTFILES_DIR/shell/zshrc"          "$HOME/.zshrc"
link_file "$DOTFILES_DIR/shell/starship.toml"  "$HOME/.config/starship.toml"
link_file "$DOTFILES_DIR/git/gitconfig"          "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/gitconfig-personal" "$HOME/.gitconfig-personal"
link_file "$DOTFILES_DIR/git/gitconfig-adobe"    "$HOME/.gitconfig-adobe"
link_file "$DOTFILES_DIR/git/gitconfig-corp"     "$HOME/.gitconfig-corp"
link_file "$DOTFILES_DIR/ghostty/config"       "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/claude/statusline.sh" "$HOME/.claude/statusline.sh"
link_file "$DOTFILES_DIR/shell/atuin.toml"     "$HOME/.config/atuin/config.toml"

echo "→ Creating local config files (not version-controlled)..."
touch "$HOME/.zshrc.local"
touch "$HOME/.aliases.local"

echo "→ Creating repo directories..."
mkdir -p "$HOME/dev" "$HOME/work/adobe" "$HOME/work/corp"

if command -v atuin >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/share/atuin"
fi

if [[ "${SHELL:-}" != *zsh ]]; then
  echo "Note: current shell is ${SHELL:-unknown}. If needed: chsh -s /bin/zsh"
fi

echo ""
echo "✓ Done. Restart your terminal, then run: doctor-shell"
echo ""
echo "Next steps (first-time setup):"
echo "  1. Edit ~/.gitconfig-adobe and ~/.gitconfig-corp with your email addresses"
echo "  2. Set up SSH keys — see README.md"
echo "  3. gh auth login --hostname github.com          # personal account"
echo "  4. gh auth login --hostname github.com          # adobe account (run again)"
echo "  5. gh auth login --hostname git.corp.adobe.com  # corp"
echo "  6. Put secrets/tokens in ~/.zshrc.local"
