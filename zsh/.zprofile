# ~/.zprofile — ログインシェルで 1 回だけ読まれる
# /etc/zprofile の path_helper が PATH を並べ替えた後に走るので、Homebrew はここで通す

# Homebrew (Apple Silicon: /opt/homebrew, Intel: /usr/local)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
