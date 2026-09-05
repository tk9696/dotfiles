#!/bin/bash
# macOS の設定を再現する。旧 Mac (macOS 15) の現行値を defaults read で採取したもの。
# 再実行しても問題ない。

set -euo pipefail

echo "==> macOS defaults"

# ---- 外観 ----
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# ---- キーボード ----
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3            # フルキーボードアクセス
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true  # F1〜F12 を標準のファンクションキーとして使う

# ---- トラックパッド / マウス ----
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3
defaults write NSGlobalDomain com.apple.mouse.scaling -float 3

# ---- Dock ----
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 35
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false   # 最近の使用状況で Spaces を並べ替えない

# ---- Finder ----
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"   # リスト表示
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder NewWindowTarget -string "PfHm"        # 新規ウィンドウはホーム
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ---- スクリーンショット ----
defaults write com.apple.screencapture type -string "jpg"
defaults write com.apple.screencapture disable-shadow -bool true

# ---- メニューバー ----
defaults write com.apple.menuextra.clock Show24Hour -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.controlcenter BatteryShowPercentage -bool true

# ---- Dock の固定アプリ ----
if command -v dockutil >/dev/null 2>&1; then
  echo "==> Dock apps"
  dockutil --no-restart --remove all >/dev/null
  for app in \
    "/Applications/Google Chrome.app" \
    "/System/Cryptexes/App/System/Applications/Safari.app" \
    "/Applications/Visual Studio Code.app" \
    "/Applications/Sourcetree.app" \
    "/Applications/iTerm.app" \
    "/Applications/Notion.app" \
    "/Applications/Slack.app" \
    "/Applications/Claude.app" \
    "/Applications/Figma.app" \
    "/System/Applications/System Settings.app"; do
    if [ -d "$app" ]; then
      dockutil --no-restart --add "$app" >/dev/null
    else
      echo "  skip (not installed): $app"
    fi
  done
else
  echo "  dockutil が無いので Dock の並びはスキップ"
fi

killall Dock Finder SystemUIServer 2>/dev/null || true
echo "==> done (外観の一部はログアウト後に反映)"
