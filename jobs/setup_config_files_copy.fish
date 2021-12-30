
echo "remove .config folder if exist"
rm -rf ~/.config 2> /dev/null

echo "add .config filder"
mkdir ~/.config

echo "make link to .config folder"
ln -s "$pwd/.config" ~/.config

echo "pwd"
pwd

# Git
assert_has git
ln -s "$pwd/.gitconfig" ~/.gitconfig

echo "✅ Copy tig config"
assert_has tig
ln -s "$pwd/.tigrc" ~/.tigrc

echo "✅ Copy VSCode config"
mkdir -p ~/Library/Application\ Support/Code/
ln -sf "$pwd/vscode/User/" ~/Library/Application\ Support/Code/