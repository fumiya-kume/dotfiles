#!/bin/bash

echo $(which fish) | sudo tee -a /etc/shells 2>&1 > /dev/null
sudo chsh -s /opt/homebrew/bin/fish > /dev/null
