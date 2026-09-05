# ~/.zshrc — 対話シェルの設定

# ---- history ----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups   # 重複は最新だけ残す
setopt hist_ignore_space      # 先頭スペースのコマンドは履歴に残さない
setopt hist_reduce_blanks
setopt share_history          # 複数タブで履歴を共有
setopt inc_append_history
setopt extended_history

# ---- options ----
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt interactive_comments
setopt no_beep
bindkey -e

# ---- PATH ----
path=("$HOME/.local/bin" $path)
typeset -U path

BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"

# ---- completion ----
if [[ -n "$BREW_PREFIX" ]]; then
  fpath=("$BREW_PREFIX/share/zsh-completions" "$BREW_PREFIX/share/zsh/site-functions" $fpath)
fi
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # 大文字小文字を無視
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---- tools ----
command -v mise   >/dev/null && eval "$(mise activate zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
command -v fzf    >/dev/null && source <(fzf --zsh)

# ---- aliases ----
if command -v eza >/dev/null; then
  alias ls='eza'
  alias ll='eza -la --git --group-directories-first'
  alias lt='eza --tree --level=2'
else
  alias ll='ls -la'
fi
alias g='git'
alias tf='terraform'
alias ..='cd ..'

# ---- prompt ----
command -v starship >/dev/null && eval "$(starship init zsh)"

# ---- plugins (末尾に置く) ----
if [[ -n "$BREW_PREFIX" ]]; then
  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ---- マシン固有 / 機密 (リポジトリ管理外) ----
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
