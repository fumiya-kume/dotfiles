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
alias h='history 0| awk "!a[\$0]++" | peco --initial-index=-1'

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
bindkey '^R' history-incremental-search-backward
. "$HOME/.local/bin/env"

# Added by Windsurf
export PATH="/Users/kuu/.codeium/windsurf/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kuu/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
alias claude="/Users/kuu/.claude/local/claude"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# --- zsh-autosuggestions ---
# 設定はsource前に定義
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Homebrewのインストール先に応じてsource
if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 受け入れをCtrl-fに割当（→でも確定可能）
bindkey '^F' autosuggest-accept
# --- /zsh-autosuggestions ---
