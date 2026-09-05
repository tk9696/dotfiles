# Brewfile — `brew bundle --file=Brewfile` で一括インストール
# 追加/削除したら `brew bundle check` と `brew bundle cleanup` で差分を確認する

tap "aws/tap"

# ---- CLI: 基本 ----
brew "git"
brew "git-lfs"
brew "gh"
brew "glab"
brew "jq"
brew "ripgrep"
brew "fd"
brew "fzf"
brew "bat"
brew "eza"
brew "git-delta"
brew "tree"
brew "wget"
brew "watch"
brew "htop"
brew "tldr"
brew "telnet"
brew "tmux"

# ---- CLI: シェル ----
brew "starship"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zsh-completions"

# ---- 開発環境 / バージョン管理 ----
brew "mise"        # node / python / ruby / terraform を一元管理
brew "direnv"
brew "uv"
brew "go"

# ---- クラウド / インフラ ----
brew "awscli"
brew "aws/tap/aws-sam-cli"
brew "tflint"
brew "mysql-client"

# ---- macOS ----
brew "dockutil"    # macos/defaults.sh で Dock を並べる

# ---- 必要になったら入れる（依存が多い / 使用頻度が低い） ----
# brew "ffmpeg"
# brew "imagemagick"
# brew "graphviz"
# brew "pandoc"
# brew "jpegoptim"
# brew "pngquant"
# brew "unar"

# ---- GUI アプリ ----
cask_args appdir: "/Applications"

# ブラウザ / コミュニケーション
cask "google-chrome"
cask "slack"
cask "microsoft-teams"
cask "zoom"

# エディタ / 開発
cask "visual-studio-code"
cask "cursor"
cask "zed"
cask "iterm2"
cask "docker-desktop"
cask "sourcetree"
cask "tableplus"
cask "sequel-ace"
cask "charles"
cask "cyberduck"       # FileZilla の代替（FileZilla は cask 無し）
cask "drawio"
cask "figma"

# AI
cask "claude"

# AWS
cask "aws-vault-binary"   # 旧 aws-vault は rename された
cask "aws-vpn-client"
cask "session-manager-plugin"   # ssh の SSM ProxyCommand に必要

# ユーティリティ
cask "alfred"
cask "logi-options+"
cask "notion"
cask "google-drive"
cask "box-drive"
cask "microsoft-word"
cask "microsoft-excel"
cask "microsoft-powerpoint"
cask "kobo"

# ---- VSCode 拡張 ----
vscode "amazonwebservices.aws-toolkit-vscode"
vscode "anthropic.claude-code"
vscode "arjun.swagger-viewer"
vscode "batisteo.vscode-django"
vscode "biomejs.biome"
vscode "bmewburn.vscode-intelephense-client"
vscode "christian-kohler.path-intellisense"
vscode "dbaeumer.vscode-eslint"
vscode "digitalbrainstem.javascript-ejs-support"
vscode "esbenp.prettier-vscode"
vscode "foxundermoon.shell-format"
vscode "hashicorp.terraform"
vscode "humao.rest-client"
vscode "mechatroner.rainbow-csv"
vscode "mosapride.zenkaku"
vscode "ms-azuretools.vscode-containers"
vscode "ms-python.black-formatter"
vscode "ms-python.debugpy"
vscode "ms-python.isort"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode.remote-explorer"
vscode "njpwerner.autodocstring"
vscode "openai.chatgpt"
vscode "orta.vscode-jest"
vscode "pkief.material-icon-theme"
vscode "redhat.vscode-yaml"
vscode "vue.volar"
vscode "zamerick.vscode-caddyfile-syntax"
