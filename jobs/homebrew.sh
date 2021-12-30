echo "✅ Copy Brewfile"
ln -sf "$(pwd)/Brewfile" ~

echo "✅ Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 

echo "✅ Setup Homebrew bundle"
brew tap homebrew/bundle

echo "✅ Brew update and upgrade"
brew update > /dev/null && brew upgrade > /dev/null

echo "✅ Bundle Install"
brew bundle > /dev/null
