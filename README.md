# dotfiles

[![E2E_Test](https://github.com/fumiya-kume/dotfiles/actions/workflows/e2e_test.yml/badge.svg)](https://github.com/fumiya-kume/dotfiles/actions/workflows/e2e_test.yml)

Personal dotfiles managed with symlinks and a simple shell script.

## Quick Start

```bash
git clone https://github.com/fumiya-kume/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## With Homebrew Packages

```bash
./install.sh --with-packages
```

This will:
- Install Homebrew (if not present)
- Run `brew bundle` with `~/.Brewfile`
- Install `uv` (Python package manager)

## Update

```bash
cd ~/dotfiles
git pull
# Symlinks auto-update - no additional commands needed!
```

## Structure

```
~/dotfiles/
├── install.sh          # Main setup script
├── home/               # Files symlinked to ~/
│   ├── .zshrc
│   ├── .zprofile
│   ├── .gitconfig
│   └── ...
├── .config/            # Files symlinked to ~/.config/
│   ├── starship.toml
│   ├── ghostty/
│   └── ...
├── .ssh/               # SSH config (symlinked with 600 permissions)
├── .gnupg/             # GPG config
└── scripts/            # Setup scripts
    ├── install-homebrew.sh
    └── install-uv.sh
```

## 1Password Integration

SSH keys and secrets are managed via 1Password:

```bash
# GitHub CLI (authenticates via 1Password)
gh repo list

# Run command with secrets from 1Password
with-secrets ./deploy.sh

# Use custom env file
OP_ENV_FILE=~/.config/op/work.template with-secrets ./script.sh
```

## macOS Defaults

```bash
./scripts/setup-macos.sh
```
