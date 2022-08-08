rm -rf ~/.config
ln -fs "$(pwd)/config/.config/" ~
ln -fs "$(pwd)/config/.gnupg/" ~
ln -fs "$(pwd)/config/.tigrc" ~/.tigrc
ln -fs "$(pwd)/config/.gitconfig.remote" ~/.gitconfig.remote
ln -fs "$(pwd)/config/.gitmodules" ~/.gitmodules
ln -fs "$(pwd)/config/.gitignore" ~/.gitignore
ln -fs "$(pwd)/config/.Brewfile" ~/.Brewfile
ln -fs "$(pwd)/config/.hammerspoon" ~/.hammerspoon
ln -fs "$(pwd)/config/.tmux/" ~/.tmux

mkdir -p "~/Library/Application\ Support/Code/"
ln -nfs "$(pwd)/config/vscode/User/" "~/Library/Application\ Support/Code/"

ln -fs "$(pwd)/config/.ssh/config" ~/.ssh/config
git config --global include.path "~/.gitconfig.remote"
git config --global core.excludesfile "~/.gitignore"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -q' > /dev/null
