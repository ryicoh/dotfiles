# rustの設定
# 一応arm64とx86_64の両方設定していたが、armが生き残った
# if [[ `arch` == 'arm64' ]]; then
#        export RUSTUP_HOME=$HOME/.rustup-arm64
#        export CARGO_HOME=$HOME/.cargo-arm64
#        source $HOME/.cargo-arm64/env
# fi

export HOMEBREW_NO_AUTO_UPDATE=1
if [[ `arch` == 'arm64' ]]; then
	export PATH="/opt/homebrew/bin":"$PATH"
fi

# anyenv はいろんな言語のバージョンを管理してくれるやつ
# 毎回 evalするとすごい遅いので、基本は手動管理
# eval "$(anyenv init -)"
export PATH="$HOME/.anyenv/envs/nodenv/versions/16.14.0/bin/:$PATH"
export PATH="$HOME/.anyenv/envs/pyenv/versions/3.10.2/bin/:$PATH"
export PATH="$HOME/.anyenv/envs/rbenv/versions/3.1.0/bin/:$PATH"

# flutter のパス設定
export PATH="$PATH:/usr/local/flutter/bin"
# flutterのコマンドを使うための設定
export PATH="$PATH":"$HOME/.pub-cache/bin"
# go のパス設定
# export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
# cargo のパス設定
export PATH="$HOME/.cargo/bin:$PATH"

# 補完の設定
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# 自動提案
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# gcloudコマンドの設定
# source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# gcloudで使うpythonを指定
# export CLOUDSDK_PYTHON=/usr/bin/python

# fzf は曖昧検索してくれるやつ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# 色関係
export CLICOLOR=1
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ヒストリーとかその他諸々
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# pushするときリモート側にブランチがなければ自動で作る
function p() {
  git push
  if [[ $? -eq 0 ]]; then
    return
  fi
  git push --set-upstream origin "`git rev-parse --abbrev-ref HEAD`"
  prURL=`gh pr create --fill --assignee @me | grep http`
  open $prURL
}

# <C-w>押した時、/で止まるようにする
# https://unix.stackexchange.com/questions/250690/how-to-configure-ctrlw-as-delete-word-in-zsh
function my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word

function run_fg_command() { fg }
zle -N run_fg_command
bindkey '^Z' run_fg_command

# kubectlで使うエディタ
export KUBE_EDITOR=nvim

# gitで使うエディタ
# export GIT_EDITOR="nvim -u NORC"

# エイリアス
alias vi="nvim"
alias k="kubectl"
alias watch="watch -d "
alias g="git"
# alias rm='trash -F'

# Javaへのパス
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# manをvimで見る
# export MANPAGER="col -b -x | nvim -u NORC"

eval "$(gh completion -s zsh)"

export PATH="/opt/flutter/bin:$PATH"

[ -f "/Users/ryicoh/.ghcup/env" ] && source "/Users/ryicoh/.ghcup/env" # ghcup-env
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
