# config
mkdir ~/.config
ln -s "$pwd/.config" ~/.config

# Git

assert_has git
ln -s "$pwd/.gitconfig" ~/.gitconfig

# Tig

assert_has tig
ln -s "$pwd/.tigrc" ~/.tigrc

# VSCode

ln -sf "$pwd/vscode/User/" ~/Library/Application\ Support/Code/