if [[ `uname -m` == 'arm64' ]]; then
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells 2>&1 > /dev/null
   sudo chsh -s /opt/homebrew/bin/fish > /dev/null
else
   echo /usr/local/bin/fish | sudo tee -a /etc/shells 2>&1 > /dev/null
   sudo chsh -s /usr/local/bin/fish > /dev/null
fi