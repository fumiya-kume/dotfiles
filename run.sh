#!/usr/bin/zsh

echo "✅ Install Xcode"
sudo xcode-select --install > /dev/null

echo "✅ Copy files"

DOTFILE_PATH="~/ghq/dotfiles"
ln -fs "$DOTFILE_PATH/config/.config/" ~
ln -fs "$DOTFILE_PATH/config/.gnupg/" ~
ln -fs "$DOTFILE_PATH/config/.tigrc" ~/.tigrc
ln -fs "$DOTFILE_PATH/config/.gitconfig.remote" ~/.gitconfig.remote
ln -fs "$DOTFILE_PATH/config/.gitmodules" ~/.gitmodules
ln -fs "$DOTFILE_PATH/config/.gitignore" ~/.gitignore
ln -fs "$DOTFILE_PATH/config/.Brewfile" ~/.Brewfile
ln -fs "$DOTFILE_PATH/config/.hammerspoon" ~/.hammerspoon
ln -fs "$DOTFILE_PATH/config/.tmux/" ~/.tmux
ln -fs "$DOTFILE_PATH/config/.ssh/config" ~/.ssh/config
ln -fs "$DOTFILE_PATH/config/gpg-key.conf" ~

mkdir -p "~/Library/Application\ Support/Code/"
ln -nfs "$(pwd)/config/vscode/User/" "~/Library/Application\ Support/Code/"

git config --global include.path "~/.gitconfig.remote"
git config --global core.excludesfile "~/.gitignore"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -q' > /dev/null

echo "✅ Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/kuu/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew tap homebrew/bundle > /dev/null && brew bundle install --global -q

echo "✅ Set fish"
echo $(which fish) | sudo tee -a /etc/shells 2>&1 > /dev/null
sudo chsh -s /opt/homebrew/bin/fish > /dev/null

echo "✅ Set Mac defaults"
. ./command/mac_defaults.sh

echo "✅ Setup gn"
mkdir ~/tmp
git clone https://gn.googlesource.com/gn ~/tmp/gn -q
python ~/tmp/gn/build/gen.py && ninja -C ~/tmp/gn/out > /dev/null
mkdir -p ~/.bin && cp ~/tmp/gn/out/gn ~/.bin && rm -rf ~/tmp

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
