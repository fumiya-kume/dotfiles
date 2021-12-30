/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null

brew tap homebrew/bundle > /dev/null
brew upgrade > /dev/null
brew bundle install --file ~/.Brewfile > /dev/null
