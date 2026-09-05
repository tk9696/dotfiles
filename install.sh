#!/bin/bash
# 新 Mac のセットアップ。冪等 (何度実行しても同じ結果)。
#
#   ./install.sh              全部実行
#   ./install.sh --dry-run    何をするか表示だけ
#   ./install.sh --no-brew    brew bundle を飛ばす
#   ./install.sh --no-macos   macos/defaults.sh を飛ばす

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
DO_BREW=1
DO_MACOS=1

for arg in "$@"; do
  case "$arg" in
    --dry-run)  DRY_RUN=1 ;;
    --no-brew)  DO_BREW=0 ;;
    --no-macos) DO_MACOS=0 ;;
    *) echo "unknown option: $arg"; exit 1 ;;
  esac
done

run() {
  if [ "$DRY_RUN" = 1 ]; then
    echo "  [dry-run] $*"
  else
    "$@"
  fi
}

# ---- symlink 対象 (リポジトリ内パス → ~ 以下のパス) ----
LINKS=(
  "zsh/.zshenv:$HOME/.zshenv"
  "zsh/.zprofile:$HOME/.zprofile"
  "zsh/.zshrc:$HOME/.zshrc"
  "git/.gitconfig:$HOME/.gitconfig"
  "git/ignore:$HOME/.config/git/ignore"
  "config/mise/config.toml:$HOME/.config/mise/config.toml"
  "config/starship.toml:$HOME/.config/starship.toml"
  "config/zed/settings.json:$HOME/.config/zed/settings.json"
  "tmux/.tmux.conf:$HOME/.tmux.conf"
  "vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json"
  "vscode/keybindings.json:$HOME/Library/Application Support/Code/User/keybindings.json"
  "claude/settings.json:$HOME/.claude/settings.json"
)

link_file() {
  local src="$DOTFILES/$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "  ok      $dst"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "  backup  $dst -> $BACKUP_DIR/"
    run mkdir -p "$BACKUP_DIR"
    run mv "$dst" "$BACKUP_DIR/"
  fi
  echo "  link    $dst -> $src"
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
}

# ---- 1. Xcode Command Line Tools ----
echo "==> Xcode Command Line Tools"
if ! xcode-select -p >/dev/null 2>&1; then
  run xcode-select --install
  echo "  CLT のインストールが終わったら install.sh を再実行してください"
  exit 1
fi
echo "  ok"

# ---- 2. Homebrew ----
echo "==> Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
echo "  $(command -v brew || echo '(dry-run)')"

# ---- 3. brew bundle ----
if [ "$DO_BREW" = 1 ]; then
  echo "==> brew bundle"
  run brew bundle --file="$DOTFILES/Brewfile"
fi

# ---- 4. symlink ----
echo "==> symlink"
for entry in "${LINKS[@]}"; do
  link_file "${entry%%:*}" "${entry#*:}"
done

# ---- 5. ローカル設定ファイル (リポジトリ管理外) ----
echo "==> local files"
if [ ! -f "$HOME/.gitconfig.local" ]; then
  echo "  create  ~/.gitconfig.local (git/gitconfig.local.example から)"
  run cp "$DOTFILES/git/gitconfig.local.example" "$HOME/.gitconfig.local"
else
  echo "  ok      ~/.gitconfig.local"
fi
if [ ! -f "$HOME/.ssh/config" ]; then
  echo "  create  ~/.ssh/config (ssh/config.example から)"
  run mkdir -p "$HOME/.ssh"
  run chmod 700 "$HOME/.ssh"
  run cp "$DOTFILES/ssh/config.example" "$HOME/.ssh/config"
  run chmod 600 "$HOME/.ssh/config"
else
  echo "  ok      ~/.ssh/config"
fi

# ---- 6. mise ----
if command -v mise >/dev/null 2>&1; then
  echo "==> mise install"
  run mise install --yes
fi

# ---- 7. macOS defaults ----
if [ "$DO_MACOS" = 1 ]; then
  run bash "$DOTFILES/macos/defaults.sh"
fi

# ---- 8. ログインシェル ----
echo "==> login shell"
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "  chsh -s /bin/zsh"
  run chsh -s /bin/zsh
else
  echo "  ok      /bin/zsh"
fi

echo
echo "完了。README.md の「手動移行チェックリスト」を確認してください。"
