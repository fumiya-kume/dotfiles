#!/usr/bin/env bash
set -euo pipefail

if command -v uv >/dev/null 2>&1; then
  echo "uv already installed, skipping."
  exit 0
fi

echo "Installing uv..."
if command -v brew >/dev/null 2>&1; then
  brew install uv
else
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
