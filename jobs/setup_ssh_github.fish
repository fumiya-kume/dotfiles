echo "✅ Generate SSH key for Github"
ln -s "$pwd/.ssh" ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/github -N '' -q

echo "SSH key for Github"
echo "------------------"
pbcopy < ~/.ssh/github.pub && pbpaste
echo "------------------"