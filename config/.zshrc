source /opt/homebrew/opt/spaceship/spaceship.zsh
# 重複を記録しない
setopt hist_ignore_dups
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt share_history
SAVEHIST=10000
HISTSIZE=10000

# Change directory to a repository selected from ghq list
g() {
  local repo=$(ghq list | peco)
  if [[ -n "$repo" ]]; then
    cd $(ghq root)/$repo
  fi
}

# Switch to a branch selected from a list of branches
alias gb='git switch -m "$(git branch -a --sort=-authordate | grep -v -e "->" -e "*" | perl -pe "s/^\h+//g" | perl -pe "s#^remotes/origin/###" | perl -nle "print if !\$c{$_}++" | peco)"'
# gb() {
#  local branch=$(git branch -a --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco)
#  if [[ -n "$branch" ]]; then
#    git switch -m "$branch"
#  fi
#}

# alias cd='builtin cd $@ && ls;'
alias cl='clear'
alias ts='tig status'
alias gp='git pull --autostash'
alias tssh='ssh $(tailscale status | awk "/^# / {next} /^[ \t]*$/ {next} /^\-/ {next} {print \$2}" | peco | tr "\n" "\0")'

# function h() {
h() { eval $(history -n -r | awk '!a[$0]++' | peco --initial-index=-1); }
#  local selected
#  selected=$(history -E 1| awk '!a[$0]++' | peco --initial-index=-1)
#  if [[ -n "$selected" ]]; then
#    eval "$selected"
#  fi
#}
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
