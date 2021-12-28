set fish_greeting ""

set PATH /Users/kuxu/flutter/bin  $PATH
# set -x PATH $HOME/.anyenv/bin $PATH
set PATH $HOME/.jenv/bin $PATH

# ~/.anyenv/bin/anyenv init - fish | source
status --is-interactive; and source (jenv init -|psub)

function cl
   clear
end

function gb
   git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
end

function gbp
   gh pr list --limit 9999 | peco | awk '{ print $1 }' | xargs gh pr checkout
end

function gsf 
   git diff --name-only --cached
end

function ga
    git add  (git diff --name-only HEAD^ | peco)
end

function g
   cd (ghq root)/(ghq list | peco)
end

function git-branch-remove
  git branch | peco | xargs git branch -D
end

function bgr
   git branch | grep -v "master" | xargs git branch -D
end


function gadd
   git diff --name-only | peco | xargs git add
end

abbr -a gcb git checkout -b
abbr -a ts tig status

starship init fish | source
