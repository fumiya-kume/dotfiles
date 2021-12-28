#!/bin/fish

# config
mkdir ~/.config
ln -s "$pwd/.config" ~/.config

# Git

assert_has git
ln -s "$pwd/.gitconfig" ~/.gitconfig

# Tig

assert_has tig
ln -s "$pwd/.tigrc" ~/.tigrc

# VSCode

ln -sf "$pwd/vscode/User/" ~/Library/Application\ Support/Code/

# XCode

xcode-select --install
sudo xcodebuild -license

# Mac Defaults
defaults write com.apple.finder AppleShowAllFiles TRUE
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
defaults write com.apple.commerce AutoUpdate -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false
defaults write com.apple.dock autohide -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false 
defaults write com.apple.dock static-only -bool true
defaults write com.apple.TextEdit RichText -int 0
sudo chflags nohidden /Volumes
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.clock DateFormat -string "M\u6708d\u65e5(EEE)  H:mm:ss"
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"

killall Finder
