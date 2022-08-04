if [ -f "$1" ]; then
  echo "  🚀 Generate SSH key for Github skipped"
else 
  echo "SSH key for Github"
  ssh-keygen -t ed25519 -f ~/.ssh/github -N '' -C "fumiya.kume@hotmail.com" -q > /dev/null
  echo "  ✅ Generate succeed"
fi
