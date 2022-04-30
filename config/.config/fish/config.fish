set fish_greeting ""

set PATH ~/flutter/bin  $PATH
set PATH ~/.bin $PATH
set PATH /opt/homebrew/bin/brew $PATH
set PATH /opt/homebrew/bin $PATH
# set -x PATH $HOME/.anyenv/bin $PATH
set PATH $HOME/.jenv/bin $PATH
set PATH $HOME/android-sdk/cmdline-tools/latest/bin $PATH
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH /usr/local/bin $PATH
set -x ANDROID_SDK_ROOT $HOME/Library/Android/sdk


# ~/.anyenv/bin/anyenv init - fish | source
# status --is-interactive; and source (jenv init -|psub)

alias gcm='git commit -m'
alias vim='nvim'
alias gpush='git push origin (git rev-parse --abbrev-ref HEAD)'
alias gpull='git pull origin (git rev-parse --abbrev-ref HEAD)'

starship init fish | source
