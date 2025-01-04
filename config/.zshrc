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

alias g='cd $(ghq list | peco | xargs -I {} echo $(ghq root)/{})'
alias gb='git switch -m $(git branch -a | grep -v -e "->" -e "*" | perl -pe "s/^\h+//g" | while read -r line; do echo ${line#remotes/origin/}; done | uniq | peco)'
alias cl='clear'
alias ts='tig status'
alias gp='git pull --autostash'
alias tssh='ssh $(tailscale status | awk "/^# / {next} /^[ \t]*$/ {next} /^\-/ {next} {print \$2}" | peco | tr "\n" "\0")'
alias h='eval $(history -n -r | awk "!a[\$0]++" | peco --initial-index=-1)'

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
