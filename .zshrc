autoload -Uz compinit && compinit

# zplug
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh
zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-autosuggestions" # 入力途中に候補をうっすら表示
zplug "zsh-users/zsh-completions" # 補完を更に強化する
zplug "zsh-users/zsh-history-substring-search", defer:3 # ヒストリの補完を強化する
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # コマンドを種類ごとに色付け

zplug 'b4b4r07/zplug-cd', lazy:yes
zplug 'b4b4r07/zplug-doctor', lazy:yes
zplug 'b4b4r07/zplug-rm', lazy:yes

# git
zplug "plugins/git", from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"

# theme
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# docker
zplug "felixr/docker-zsh-completion"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# tmux
# if [[ ! $TERM =~ screen ]]; then
#     exec tmux
# fi

# gcp
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then
	source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
fi

if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

# kubectl
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/kubectl' ]; then
	source <(kubectl completion zsh)
fi

# neovim
export XDG_CONFIG_HOME=~/.config


setopt auto_cd
setopt nobeep

alias vi="nvim"
alias ls="ls -GF"
alias gls="gls --color"
alias docker-clear="docker rm -f \$(docker ps -aq) && docker rmi -f \$(docker images -q)"
alias k="kubectl"

export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"

export PATH="/Users/ryicoh/flutter/bin:$PATH"
export PATH="/Users/ryicoh/Library/Android/sdk/platform-tools:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ryicoh/.sdkman"

