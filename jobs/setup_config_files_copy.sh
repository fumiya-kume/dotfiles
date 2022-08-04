ln -s -f "$(pwd)/config/.config/" ~
ln -s -f "$(pwd)/config/.gnupg/" ~
ln -fs "$(pwd)/config/.tigrc" ~/.tigrc
ln -fs "$(pwd)/config/.gitconfig.remote" ~/.gitconfig.remote
mkdir -p "~/Library/Application\ Support/Code/"
ln -nfs "$(pwd)/config/vscode/User/" "~/Library/Application\ Support/Code/"
ln -s "$(pwd)/config/.Brewfile" ~/.Brewfile
ln -s "$(pwd)/config/.hammerspoon" ~/.hammerspoon
ln -s "$(pwd)/config/.tmux/" ~/.tmux

ln -fs "$(pwd)/config/.ssh/config" ~/.ssh/config
git config --global include.path "~/.gitconfig.remote"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null
