set fish_greeting ""

set PATH /Users/kuxu/flutter/bin  $PATH
# set -x PATH $HOME/.anyenv/bin $PATH
set PATH $HOME/.jenv/bin $PATH

# ~/.anyenv/bin/anyenv init - fish | source
status --is-interactive; and source (jenv init -|psub)

abbr -a gcb git checkout -b
abbr -a ts tig status

starship init fish | source
