# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 

echo "✅ Setup Homebrew bundle"
brew tap homebrew/bundle

echo "✅ Bundle Install"
brew update > /dev/null
brew upgrade > /dev/null
brew bundle > /dev/null