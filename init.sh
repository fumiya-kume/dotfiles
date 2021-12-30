#!/bin/zsh

echo "✅ Git Clone"
git clone https://github.com/fumiya-kume/dotfiles.git ~/dotfiles -q
cd ~/dotfiles

echo "✅ Install Xcode"
. jobs/install_xcode.sh

echo "✅ Install Homebrew"
. jobs/setup_homebrew.sh

echo "✅ Set fish as default shell"
if [[ `uname -m` == 'arm64' ]]; then
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells 2>&1
   sudo chsh -s /opt/homebrew/bin/fish > /dev/null
else
   echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1
   sudo chsh -s /usr/local/bin/fish > /dev/null
fi

echo "✅ Copy files"
. jobs/setup_config_files_copy.sh

echo "✅ Set Mac defaults"
. jobs/setup_mac_defaults.sh

echo "✅ Setup SSH for Github"
. jobs/setup_ssh_github.sh
