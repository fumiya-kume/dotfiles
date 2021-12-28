#!/bin/zsh

# sudo -v

# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~

# Homebrew

echo "Install Homebrew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null

echo "Setup Homebrew bundle"

brew tap homebrew/bundle

echo "Bundle Install"

brew update > /dev/null
brew bundle > /dev/null

echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1

sudo chsh -s /usr/local/bin/fish > /dev/null
fish setup.fish
