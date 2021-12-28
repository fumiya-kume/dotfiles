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