# config
mkdir ~/.config
ln -s "$pwd/.config" ~/.config

# Git

assert_has git
ln -s "$pwd/.gitconfig" ~/.gitconfig

echo "✅ Generate SSH key for Github"
ln -s "$pwd/.ssh" ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/github -N '' -q

echo "SSH key for Github"
echo "------------------"
pbcopy < ~/.ssh/github.pub && pbpaste
echo "------------------"

# Tig
assert_has tig
ln -s "$pwd/.tigrc" ~/.tigrc

# VSCode

ln -sf "$pwd/vscode/User/" ~/Library/Application\ Support/Code/