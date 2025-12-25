#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

#=============================================================================
# Utility functions
#=============================================================================
log() { printf '\033[0;32m[✓]\033[0m %s\n' "$*"; }
warn() { printf '\033[0;33m[!]\033[0m %s\n' "$*"; }
err() { printf '\033[0;31m[✗]\033[0m %s\n' "$*" >&2; }

#=============================================================================
# Create symlink (backup existing files)
#=============================================================================
link() {
  local src="$1" dst="$2"

  # Create parent directory
  mkdir -p "$(dirname "$dst")"

  # Skip if link already correct
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    return 0
  fi

  # Backup existing file/link
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
    warn "Backed up: $dst"
  fi

  ln -s "$src" "$dst"
  log "Linked: $dst -> $src"
}

#=============================================================================
# Skip patterns for home directory
#=============================================================================
should_skip() {
  local name="$1"
  case "$name" in
    .|..) return 0 ;;
    .DS_Store|.localized) return 0 ;;
    .git|.gitignore|.gitattributes|.gitmodules) return 0 ;;
    *.swp|*.swo|*~) return 0 ;;
    .*.bak|.*.backup) return 0 ;;
    *) return 1 ;;
  esac
}

#=============================================================================
# Home directory dotfiles (home/.*)
#=============================================================================
log "Setting up home directory dotfiles..."
for f in "$DOTFILES_DIR"/home/.*; do
  [[ -e "$f" ]] || continue
  name="$(basename "$f")"
  should_skip "$name" && continue
  link "$f" "$HOME/$name"
done

#=============================================================================
# .config directory
#=============================================================================
if [[ -d "$DOTFILES_DIR/.config" ]]; then
  log "Setting up .config directory..."
  mkdir -p "$HOME/.config"
  for f in "$DOTFILES_DIR"/.config/*; do
    [[ -e "$f" ]] || continue
    name="$(basename "$f")"
    link "$f" "$HOME/.config/$name"
  done
fi

#=============================================================================
# .ssh directory (with permissions)
#=============================================================================
if [[ -d "$DOTFILES_DIR/.ssh" ]]; then
  log "Setting up .ssh directory..."
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  for f in "$DOTFILES_DIR"/.ssh/*; do
    [[ -e "$f" ]] || continue
    name="$(basename "$f")"
    chmod 600 "$f"
    link "$f" "$HOME/.ssh/$name"
  done
fi

#=============================================================================
# .gnupg directory (with permissions)
#=============================================================================
if [[ -d "$DOTFILES_DIR/.gnupg" ]]; then
  log "Setting up .gnupg directory..."
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  for f in "$DOTFILES_DIR"/.gnupg/*; do
    [[ -e "$f" ]] || continue
    name="$(basename "$f")"
    link "$f" "$HOME/.gnupg/$name"
  done
fi

#=============================================================================
# Claude Code (settings.json only)
#=============================================================================
if [[ -f "$DOTFILES_DIR/.claude/settings.json" ]]; then
  log "Setting up Claude Code settings..."
  mkdir -p "$HOME/.claude"
  link "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
fi

#=============================================================================
# Codex CLI
#=============================================================================
if [[ -d "$DOTFILES_DIR/.codex" ]]; then
  log "Setting up Codex CLI..."
  mkdir -p "$HOME/.codex"
  for f in "$DOTFILES_DIR"/.codex/*; do
    [[ -e "$f" ]] || continue
    name="$(basename "$f")"
    link "$f" "$HOME/.codex/$name"
  done
fi

#=============================================================================
# ~/Library (macOS only)
#=============================================================================
if [[ -d "$DOTFILES_DIR/Library" && "$(uname)" == "Darwin" ]]; then
  log "Setting up ~/Library..."

  if [[ -d "$DOTFILES_DIR/Library/Application Support" ]]; then
    for app in "$DOTFILES_DIR/Library/Application Support"/*; do
      [[ -d "$app" ]] || continue
      app_name="$(basename "$app")"
      for subdir in "$app"/*; do
        [[ -d "$subdir" ]] || continue
        subdir_name="$(basename "$subdir")"
        mkdir -p "$HOME/Library/Application Support/$app_name/$subdir_name"
        for f in "$subdir"/*; do
          [[ -e "$f" ]] || continue
          name="$(basename "$f")"
          link "$f" "$HOME/Library/Application Support/$app_name/$subdir_name/$name"
        done
      done
    done
  fi
fi

#=============================================================================
# uv zsh completion (auto-generate if needed)
#=============================================================================
setup_uv_completion() {
  if ! command -v uv >/dev/null 2>&1; then
    return 0
  fi

  local brew_comp
  brew_comp="$(command -v brew >/dev/null 2>&1 && brew --prefix 2>/dev/null || true)/share/zsh/site-functions/_uv"
  if [[ -n "${brew_comp}" && -r "${brew_comp}" ]]; then
    return 0
  fi

  local zsf_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
  mkdir -p -- "$zsf_dir"
  local out="$zsf_dir/_uv"

  [[ -f "$out" ]] && return 0

  for cmd in \
    "uv generate-shell-completion zsh" \
    "uv --generate-completion zsh" \
    "uv completions zsh"; do
    if output=$(eval "$cmd" 2>/dev/null) && [[ -n "$output" ]]; then
      printf '%s\n' "$output" > "$out"
      log "Generated uv zsh completion: $out"
      return 0
    fi
  done
}
setup_uv_completion

#=============================================================================
# Optional: Install packages (--with-packages flag)
#=============================================================================
if [[ "${1:-}" == "--with-packages" ]]; then
  log "Running setup scripts..."

  if [[ ! -x "/opt/homebrew/bin/brew" && ! -x "/usr/local/bin/brew" ]]; then
    if [[ -f "$DOTFILES_DIR/scripts/install-homebrew.sh" ]]; then
      log "Installing Homebrew..."
      bash "$DOTFILES_DIR/scripts/install-homebrew.sh"
    fi
  fi

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  if command -v brew >/dev/null 2>&1 && [[ -f "$HOME/.Brewfile" ]]; then
    log "Running brew bundle..."
    brew bundle --global
  fi

  if [[ -f "$DOTFILES_DIR/scripts/install-uv.sh" ]] && ! command -v uv >/dev/null 2>&1; then
    log "Installing uv..."
    bash "$DOTFILES_DIR/scripts/install-uv.sh"
  fi
fi

#=============================================================================
# Done
#=============================================================================
echo ""
log "Done! Restart your shell or run: source ~/.zshrc"
echo ""
echo "Quick test commands:"
echo "  ls -la ~/.zshrc              # Should point to ~/dotfiles/home/.zshrc"
echo "  gh auth status               # Test 1Password gh integration"
echo "  with-secrets env | grep -E 'GITHUB|ANTHROPIC'  # Test op run"
