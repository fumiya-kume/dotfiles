# Prompt: built-in minimal Git prompt via vcs_info (no external deps)
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{magenta}(%b%u)%f'
zstyle ':vcs_info:git*' actionformats '%F{magenta}(%b|%a%u)%f'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
precmd() {
  vcs_info
  RPROMPT=""
}
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f ${vcs_info_msg_0_}%# '
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
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
bindkey '^R' history-incremental-search-backward

# Zsh completions (must be before compinit)
if command -v brew >/dev/null 2>&1; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi
fpath=($HOME/.local/share/zsh/site-functions $fpath)
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit -i
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Use a guarded alias for `claude` only if the command is not found.
# This prevents shadowing Homebrew's `/usr/local/bin/claude` (Intel)
# or `/opt/homebrew/bin/claude` (Apple Silicon), and only falls back
# to the legacy local install when it actually exists.
if ! command -v claude >/dev/null 2>&1; then
  if [[ -x "$HOME/.claude/local/claude" ]]; then
    alias claude="$HOME/.claude/local/claude"
  fi
fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# --- uv / local bin ---
# The official uv installer places binaries in ~/.local/bin.
# If not present in PATH, prepend it to enable commands.
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
# --- /uv / local bin ---

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

# h(): select from history with peco and execute
unalias h 2>/dev/null
h() {
  emulate -L zsh
  local selected histfile src
  histfile=${HISTFILE:-$HOME/.zsh_history}
  # Get history and reverse it to show newest first
  if src=$(builtin fc -ln 1 2>/dev/null); then
    # Reverse the order using awk (newest first)
    src=$(printf '%s\n' $src | awk '{a[NR]=$0} END{for(i=NR;i>=1;i--) print a[i]}')
  else
    src=$(sed -e 's/^: [0-9]\+:[0-9];//' -- "$histfile" 2>/dev/null || true)
    # Reverse the order using tail (newest first)
    src=$(printf '%s\n' $src | awk '{a[NR]=$0} END{for(i=NR;i>=1;i--) print a[i]}')
  fi
  selected=$(printf '%s
' "$src" | awk '!a[$0]++' | peco --initial-index=0) || return
  [[ -z "$selected" ]] && return
  print -s -- "$selected"
  echo "+ $selected"
  eval "$selected"
}
# hide typed 'h' line just before execution
autoload -Uz add-zsh-hook
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

# --- 1Password CLI Integration ---
# GitHub CLI: authenticate via 1Password Shell Plugin
alias gh="op plugin run -- gh"

# op command completion
if command -v op >/dev/null 2>&1; then
  eval "$(op completion zsh)"
fi

# Helper function to run commands with secrets from 1Password
# Usage: with-secrets ./deploy.sh
#        OP_ENV_FILE=~/.config/op/work.template with-secrets ./script.sh
with-secrets() {
  op run --env-file="${OP_ENV_FILE:-$HOME/.config/op/env.template}" -- "$@"
}
# --- /1Password CLI Integration ---
