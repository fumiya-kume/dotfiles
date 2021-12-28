#!/bin/zsh

# sudo -v

# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~

# Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/bundle
brew bundle

# Fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
sudo chsh -s /usr/local/bin/fish
fish setup.fish
