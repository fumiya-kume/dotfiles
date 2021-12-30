#!/bin/zsh

echo "✅ Git Clone"
git clone https://github.com/fumiya-kume/dotfiles.git ~/dotfiles
cd ~/dotfiles

echo "✅ Install Xcode"
sh jobs/install_xcode.sh

echo "✅ Install Homebrew"
sh jobs/setup_homebrew.sh

echo "✅ Set fish as default shell"
echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
sudo chsh -s /usr/local/bin/fish

echo "✅ Copy files"
fish jobs/setup_config_files_copy.fish

echo "✅ Set Mac defaults"
fish jobs/setup_mac_defaults.fish
