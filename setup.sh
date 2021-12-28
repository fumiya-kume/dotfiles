#!/bin/zsh

echo "Install Xcode"
sh jobs/setup_xcode_install.sh > /dev/null

# Homebrew

echo "✅ Install Homebrew"

# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh) > /dev/null" 

echo "✅ Setup Homebrew bundle"
brew tap homebrew/bundle

echo "✅ Bundle Install"
brew update > /dev/null
brew bundle > /dev/null

echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
sudo chsh -s /usr/local/bin/fish > /dev/null
fish setup.fish
