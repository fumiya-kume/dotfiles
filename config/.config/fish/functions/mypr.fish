function mypr 
 gh pr list --search "is:open is:pr author:fumiya-kume" | peco | cut -f1 | xargs gh pr checkout
end
