####################################
# ⚡ Powerlevel10k Instant Prompt（高速起動用）
####################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

####################################
# 🚀 Oh My Zsh 基本設定
####################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k のプロンプト設定
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

####################################
# 🌱 Zsh 拡張設定
####################################
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy/mm/dd"

####################################
# 🔍 補完設定（COMPLEMENT）
####################################
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list '' \
  'm:{[:lower:]}={[:upper:]}' \
  '+m:{[:upper:]}={[:lower:]}'

zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2

####################################
# 🌍 環境設定
####################################
export LANG=ja_JP.UTF-8
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.deno/env:$PATH"

####################################
# 📦 エイリアス
####################################
alias pip="pip3"
alias ll="ls -la"
alias gs="git status"
alias gc="git commit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate"
alias reload="source ~/.zshrc"

####################################
# ⚙️ Zsh オプション
####################################
setopt hist_ignore_dups
setopt share_history
setopt auto_cd
setopt correct