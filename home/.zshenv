# Homebrew (must be in .zshenv for non-login shells)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
