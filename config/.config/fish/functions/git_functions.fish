function ga
    git add  (git diff --name-only HEAD^ | peco)
end

function gp
   git pull
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

function ts
   tig status
end

function gcb
   git checkout -b $argv
end