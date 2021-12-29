# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 

echo "✅ Setup Homebrew bundle"
brew tap homebrew/bundle

echo "✅ Brew update"
brew update > /dev/null
echo "✅ Brew upgrade"
brew upgrade > /dev/null
echo "✅ Brew cleanup"
brew cleanup > /dev/null
echo "✅ Bundle Install"
brew bundle