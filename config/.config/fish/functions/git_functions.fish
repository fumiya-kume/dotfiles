function ga
    git add  (git diff --name-only HEAD^ | peco)
end

function git-branch-remove
  git branch | peco | xargs git branch -D
end

function gadd
   git diff --name-only | peco | xargs git add
end

