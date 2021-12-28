#!/bin/fish

# XCode
xcode-select --install
sudo xcodebuild -license

# Copy config files
fish jobs/setup_config_files_copy.fish > /dev/null

# Mac Defaults
fish jobs/setup_mac_defaults.fish > /dev/null