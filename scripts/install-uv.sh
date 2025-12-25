#!/usr/bin/env bash
set -euo pipefail

# Idempotent installer for Astral's `uv`.

if command -v uv >/dev/null 2>&1; then
  echo "uv already installed at $(command -v uv)"
  exit 0
fi

echo "Installing uv…"

# Get OS name in lowercase (darwin, linux, etc.)
_os="$(uname | tr '[:upper:]' '[:lower:]')"

case "$_os" in
  darwin)
    if command -v brew >/dev/null 2>&1; then
      echo "Detected Homebrew; installing via brew"
      brew install uv
    else
      echo "Homebrew not found; using official installer"
      curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    ;;
  linux)
    echo "Using official installer"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ;;
  *)
    echo "Unsupported OS: $_os"
    echo "Please install uv manually: https://astral.sh/uv/"
    exit 1
    ;;
esac

echo "uv installation complete. If ~/.local/bin is not on PATH, add it."
