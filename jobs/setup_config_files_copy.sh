rm -rf ~/.config
ln -s -f "$(pwd)/config/.config/" ~
ln -s -f "$(pwd)/config/.gnupg/" ~
ln -s "$(pwd)/config/.gitconfig" ~/.gitconfig 2> /dev/null
ln -fs "$(pwd)/config/.tigrc" ~/.tigrc
mkdir -p "~/Library/Application\ Support/Code/"
ln -nfs "$(pwd)/config/vscode/User/" "~/Library/Application\ Support/Code/"
ln -s "$(pwd)/config/.Brewfile" ~/.Brewfile