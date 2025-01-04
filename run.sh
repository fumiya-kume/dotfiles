#!/usr/bin/zsh

cd ~/ghq/dotfiles

echo "✅ Install Xcode"
sudo xcode-select --install > /dev/null

echo "✅ Copy files"
rm -rf ~/.config
ln -fs "$(pwd)/config/.config/" ~
ln -fs "$(pwd)/config/.gnupg/" ~
ln -fs "$(pwd)/config/.tigrc" ~/.tigrc
ln -fs "$(pwd)/config/.gitconfig.remote" ~/.gitconfig.remote
ln -fs "$(pwd)/config/.gitmodules" ~/.gitmodules
ln -fs "$(pwd)/config/.Brewfile" ~/.Brewfile
ln -fs "$(pwd)/config/.zshrc" ~/.zshrc
ln -fs "$(pwd)/config/.ssh/config" ~/.ssh/config
ln -fs "$(pwd)/config/gpg-key.conf" ~

git config --global include.path "~/.gitconfig.remote"
git config --global core.excludesfile "~/.gitignore"

echo "✅ Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/kuu/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew tap homebrew/bundle > /dev/null && brew bundle install --global -q

echo "✅ Set Mac defaults"
. ./command/mac_defaults.sh

echo "✅ Setup SSH for Github"
if [ -f ~/.ssh/github ]; then
  echo "  🚀 Generate SSH key for Github skipped"
else 
  ssh-keygen -t ed25519 -f ~/.ssh/github -N '' -C "fumiya.kume@hotmail.com" -q > /dev/null
  echo "✅ Generate succeed"
fi

echo "✅ Setup GPG for Github"
gpg --full-gen-key -q --batch "$(pwd)/config/gpg-key.conf" > /dev/null
KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "sec" {print $5}' | tail -n 1)
echo $KEY_ID | xargs gpg --armor --export 
echo "git config --global user.signingkey $KEY_ID"
