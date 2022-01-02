set fish_greeting ""

set PATH ~/flutter/bin  $PATH
set PATH ~/.bin $PATH
set PATH /opt/homebrew/bin/brew $PATH
set PATH /opt/homebrew/bin $PATH
# set -x PATH $HOME/.anyenv/bin $PATH
set PATH $HOME/.jenv/bin $PATH
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

# ~/.anyenv/bin/anyenv init - fish | source
# status --is-interactive; and source (jenv init -|psub)

alias gcm='git commit -m'

starship init fish | source
