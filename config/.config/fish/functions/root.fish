function root 
   git rev-parse --show-superproject-working-tree --show-toplevel | head -1 | xargs cd 
end
