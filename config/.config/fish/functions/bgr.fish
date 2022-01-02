function bgr
   git branch | grep -v "master" | xargs git branch -D
end