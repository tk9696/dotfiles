# dotfiles

Mac の開発環境を再現するためのリポジトリ。`install.sh` を 1 回実行すると以下が揃う。

- Homebrew と `Brewfile` に書いたツール / GUI アプリ / VSCode 拡張
- zsh・git・mise・starship・tmux・VSCode・Zed・Claude Code の設定 (symlink)
- macOS の設定 (Dock, Finder, キーボードなど)

## 新 Mac でのセットアップ

```sh
# 1. Xcode Command Line Tools (未導入なら install.sh が案内する)
xcode-select --install

# 2. clone して実行
git clone https://github.com/tk9696/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh --dry-run   # 何をするか確認
./install.sh
```

オプション:

| フラグ | 動作 |
|---|---|
| `--dry-run` | 実行せず表示のみ |
| `--no-brew` | `brew bundle` を飛ばす |
| `--no-macos` | `macos/defaults.sh` を飛ばす |

既存ファイルは `~/.dotfiles_backup/<日時>/` に退避してから symlink する。

Homebrew 6 では third-party tap の formula は trust が必要。`brew bundle` で `aws/tap/aws-sam-cli` の警告が出たら次を実行する。

```sh
brew trust --formula aws/tap/aws-sam-cli
```

## 構成

```
Brewfile               brew / cask / vscode 拡張
install.sh             セットアップ本体
zsh/                   .zshenv / .zprofile / .zshrc
git/                   .gitconfig, ignore (~/.config/git/ignore), gitconfig.local.example
config/mise/           ランタイム (node / python / terraform)
config/starship.toml   プロンプト
config/zed/            Zed 設定
vscode/                settings.json, keybindings.json
tmux/                  .tmux.conf
ssh/config.example     ~/.ssh/config の雛形 (github のみ)
macos/defaults.sh      macOS 設定
claude/settings.json   Claude Code のユーザー設定 (plugins, model, theme)
```

### リポジトリに入れないもの

機密・マシン固有のものは symlink せず、以下のファイルで上書きする。

| ファイル | 用途 |
|---|---|
| `~/.gitconfig.local` | `user.name` / `user.email` (`git/gitconfig.local.example` から生成される) |
| `~/.zshrc.local` | マシン固有の PATH やトークン |
| `~/.ssh/config` | 案件の bastion。`ssh/config.example` から生成される |

## 手動移行チェックリスト

`install.sh` では移せないもの。旧 Mac から順にコピー / 再設定する。

- [ ] `~/.ssh/` の鍵 (`id_*`) と `~/key/*.pem`、`~/.ssh/config` の案件 bastion 設定
- [ ] `~/.aws/` (config, credentials, sso)、`~/.kube/`、`~/.terraform.d/`
- [ ] `~/.gitconfig.local` の name / email を確認
- [ ] `glab auth login` (gitlab.com と社内 GitLab。社内ホストの credential 設定は `~/.gitconfig.local` に書く)、`gh auth login`
- [ ] Chrome にログインしてプロファイルを同期 (13 プロファイル)
- [ ] ライセンス再入力: Alfred Powerpack、Charles、TablePlus
- [ ] App Store から LINE
- [ ] iTerm2 のプロファイル (フォント Monaco 12)。旧 Mac で `Settings > General > Settings` から export しておく
- [ ] Claude Code / Cursor / Zed にログイン
- [ ] 会社支給のセキュリティソフト (K7) は情シスの手順で
- [ ] Docker Desktop にログイン
- [ ] 旧 Mac 側: Google Drive の Mackup フォルダは移行完了後に `mackup uninstall` してから削除

## 棚卸しメモ (2026-09 移行時)

旧 Mac (Intel, 6 年使用) から意図的に持ち込まなかったもの。

| 分類 | 落としたもの | 理由 |
|---|---|---|
| モバイル / JVM | Xcode, Android Studio, Flutter / fvm, SDKMAN (Java 8/11, Gradle), CocoaPods, Carthage | 現在の業務で不要 |
| 科学計算 / GIS | octave, gnuplot, gdal, sfcgal, pdf2svg, Qt / PyQt, XQuartz | 使っていない。brew の依存 200 超の主因 |
| サーバー残骸 | httpd (Apache), openldap, freetds, その他ビルド依存 | Docker で代替 |
| バージョン管理 | nodenv, ndenv, rbenv, tfenv, pipx | mise / uv に統一 |
| その他 | Mackup, FileZilla (→ Cyberduck), Google 日本語入力 (未使用だった), Mini Calendar, chromedriver (Playwright 同梱) | |

必要になったら入れるもの (Brewfile にコメントアウトで残している): ffmpeg, imagemagick, graphviz, pandoc, jpegoptim, pngquant, unar

## メンテナンス

```sh
# 手で brew install したものを Brewfile と突き合わせる
brew bundle check --file=Brewfile     # Brewfile にあって入っていないもの
brew bundle cleanup --file=Brewfile   # 入っているが Brewfile に無いもの (--force で削除)

# VSCode 拡張の現状を確認
code --list-extensions
```
