rm -rf ~/.ssh 2> /dev/null
ln -s "$(pwd)/config/.ssh/" ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/github -N '' -C "fumiya.kume@hotmail.com" -q > /dev/null

echo "SSH key for Github"
echo "------------------"
pbcopy < ~/.ssh/github.pub && pbpaste
echo "------------------"