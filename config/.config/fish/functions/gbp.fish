function gbp
   gh pr list --limit 9999 | peco | awk '{ print $1 }' | xargs gh pr checkout
end
