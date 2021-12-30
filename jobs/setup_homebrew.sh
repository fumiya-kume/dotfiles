# Setup HomeBrew
ln -sf "$(pwd)/Brewfile" ~
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 

echo "✅ Setup Homebrew bundle"
brew tap homebrew/bundle

echo "✅ Brew update and upgrade"
brew update -q && brew upgrade -q
brew bundle > /dev/null
echo "✅ Bundle Install"
