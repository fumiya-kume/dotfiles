#!/bin/zsh
mkdir ~/ghq
git clone https://github.com/fumiya-kume/dotfiles.git ~/ghq/dotfiles > /dev/null
cd ~/ghq/dotfiles && sh ./workflow/full_install.sh
