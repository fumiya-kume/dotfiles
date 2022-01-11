function rpr
gh pr list --seach "is:open is:pr user-review-requested:@me" | peco | cut -f1 | xargs gh pr checkoutr
end
