rm -rf ~/.config
ln -s -f "$(pwd)/config/.config/" ~
ln -s -f "$(pwd)/config/.gnupg/" ~
ln -fs "$(pwd)/config/.tigrc" ~/.tigrc
mkdir -p "~/Library/Application\ Support/Code/"
ln -nfs "$(pwd)/config/vscode/User/" "~/Library/Application\ Support/Code/"
ln -s "$(pwd)/config/.Brewfile" ~/.Brewfile
ln -s "$(pwd)/config/.hammerspoon" ~/.hammerspoon
ln -s "$(pwd)/config/.tmux/" ~/.tmux

git config --global include.path "$(pwd)/config/.gitconfig"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null
