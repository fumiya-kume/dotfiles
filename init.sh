#!/bin/zsh

echo "✅ Git Clone"
git clone https://github.com/fumiya-kume/dotfiles.git ~/dotfiles -q
cd ~/dotfiles

echo "✅ Install Xcode"
sh jobs/install_xcode.sh

echo "✅ Install Homebrew"
sh jobs/setup_homebrew.sh

echo "✅ Set fish as default shell"
if [[ `uname -m` == 'arm64' ]]; then
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells 2>&1
   sudo chsh -s /opt/homebrew/bin/fish > /dev/null
else
   echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
   sudo chsh -s /usr/local/bin/fish > /dev/null
fi
fish
cd ~/dotfiles

echo "✅ Copy files"
fish jobs/setup_config_files_copy.fish

echo "✅ Set Mac defaults"
fish jobs/setup_mac_defaults.fish

echo "✅ Setup SSH for Github"
fish jobs/setup_ssh_github.fish
