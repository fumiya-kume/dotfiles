# Prompt: built-in minimal Git prompt via vcs_info (no external deps)
autoload -Uz vcs_info add-zsh-hook
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{magenta}(%b%u)%f'
zstyle ':vcs_info:git*' actionformats '%F{magenta}(%b|%a%u)%f'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
add-zsh-hook precmd vcs_info
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f ${vcs_info_msg_0_}%# '
setopt hist_ignore_all_dups inc_append_history hist_no_store hist_reduce_blanks share_history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias g='cd $(ghq list | peco | xargs -I {} echo $(ghq root)/{})'
alias gb='git switch -m $(git branch -a | grep -v -e "->" -e "*" | perl -pe "s/^\h+//g" | while read -r line; do echo ${line#remotes/origin/}; done | uniq | peco)'
alias cl='clear'
alias ts='tig status'
alias gp='git pull --autostash'
alias tssh='ssh $(tailscale status | awk "/^# / {next} /^[ \t]*$/ {next} /^\-/ {next} {print \$2}" | peco | tr "\n" "\0")'
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
bindkey '^R' history-incremental-search-backward

# Zsh completions (must be before compinit)
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
elif [[ -d /usr/local/share/zsh/site-functions ]]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
fpath=($HOME/.local/share/zsh/site-functions $fpath)
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit -i
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

if ! command -v claude >/dev/null 2>&1; then
  if [[ -x "$HOME/.claude/local/claude" ]]; then
    alias claude="$HOME/.claude/local/claude"
  fi
fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
bindkey '^F' autosuggest-accept

# h(): select from history with peco and execute
unalias h 2>/dev/null
h() {
  emulate -L zsh
  local selected src
  src=$(builtin fc -ln 1 2>/dev/null) || return
  selected=$(printf '%s\n' $src | awk '{a[NR]=$0} END{for(i=NR;i>=1;i--)if(!seen[a[i]]++)print a[i]}' | peco) || return
  [[ -z "$selected" ]] && return
  print -s -- "$selected"
  echo "+ $selected"
  eval "$selected"
}
# hide typed 'h' line just before execution
hide_h_preexec() {
  if [[ "$1" == "h" ]]; then
    print -n -- $'\e[1A\e[2K\r'
  fi
}
add-zsh-hook preexec hide_h_preexec

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# >>> codex-cli init >>>
_codex_update_codex_home() {
  local root
  if root=$(git rev-parse --show-toplevel 2>/dev/null); then
    export CODEX_HOME="$root/.codex"
  else
    unset CODEX_HOME
  fi
}
add-zsh-hook chpwd _codex_update_codex_home
_codex_update_codex_home
# <<< codex-cli init <<<

# 1Password
alias gh="op plugin run -- gh"
command -v op >/dev/null 2>&1 && eval "$(op completion zsh)"
with-secrets() { op run --env-file="${OP_ENV_FILE:-$HOME/.config/op/env.template}" -- "$@"; }
