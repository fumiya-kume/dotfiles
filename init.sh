#!/bin/zsh

echo "✅ Git Clone"
git clone https://github.com/fumiya-kume/dotfiles.git ~/dotfiles > /dev/null
cd ~/dotfiles > /dev/null

echo "✅ Install Xcode"
sh jobs/xcode.sh

echo "✅ Install Homebrew"
sh jobs/homebrew.sh

echo "✅ Set fish as default shell"
echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
sudo chsh -s /usr/local/bin/fish

echo "✅ Copy files"
fish jobs/files_copy.fish

echo "✅ Set Mac defaults"
fish jobs/mac_defaults.fish
