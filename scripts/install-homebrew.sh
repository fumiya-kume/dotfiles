#!/usr/bin/env bash
set -euo pipefail

# Homebrewが既にインストール済みならスキップ
if [[ -x "/opt/homebrew/bin/brew" ]] || [[ -x "/usr/local/bin/brew" ]]; then
  echo "Homebrew already installed, skipping."
  exit 0
fi

echo "Installing Homebrew..."
echo "This requires administrator privileges."
sudo -v  # Prompt for password and cache credentials
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
