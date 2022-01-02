function checkback
   git checkout (git diff --name-only HEAD^ | peco)
end
