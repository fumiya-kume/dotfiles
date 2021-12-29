#!/bin/zsh

echo "Install Xcode"
sh jobs/setup_xcode_install.sh

# Homebrew

echo "✅ Install Homebrew"
sh jobs/setup_homebrew.sh

echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
sudo chsh -s /usr/local/bin/fish

# Copy config files
fish jobs/setup_config_files_copy.fish

# Mac Defaults
fish jobs/setup_mac_defaults.fish