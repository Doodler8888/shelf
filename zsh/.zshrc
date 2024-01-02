source /home/wurfkreuz/.dotfiles/bash/scripts.sh
export GOPATH=$HOME/go
export PATH="$HOME/.nimble/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.dotfiles:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:$PATH"
export EDITOR='/usr//local/bin/nvim'
export CDPATH='.:~:/usr/local:/etc:~/.dotfiles:~/.config:~/.projects'
export HISTFILE="$HOME/.zsh_history"
export ZDOTDIR="/home/wurfkreuz/.dotfiles/zsh/"
export STARSHIP_CONFIG="/home/wurfkreuz/.dotfiles/starship/starship.toml"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .snapshots --exclude var --exclude opt --exclude lib --exclude lib64 --exclude mnt --exclude proc --exclude run --exclude sbin --exclude srv --exclude sys --exclude tmp . /'
export PATH="$PATH:/home/wurfkreuz/.ghcup/hls/2.4.0.0/bin"


# zstyle ':completion:*' menu select
# zstyle ':completion:*' special-dirs true
# setopt EXTENDED_GLOB
setopt AUTO_CD
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
HISTSIZE=2000
SAVEHIST=2000
# precmd() {}

bindkey -v
bindkey "^?" backward-delete-char

alias fnc="cd ~/.dotfiles/zsh/ && nvim functions.sh"
alias j="zellij"
alias hpr="cd /home/wurfkreuz/.dotfiles/hyprland/ && nvim hyprland.conf"
alias str="cd /home/wurfkreuz/.dotfiles/starship/ && nvim starship.toml"
alias scripts='cd /home/wurfkreuz/.dotfiles/bash/ && nvim scripts.sh'
alias rename='perl-rename'
alias d='sudo'
alias key='cd ~/.dotfiles/keyd/ && nvim default.conf'
alias h='history'
alias update_fonts='fc-cache -f -v'
alias cr='cp -r'
alias alc='cd ~/.dotfiles/alacritty && nvim ~/.dotfiles/alacritty/alacritty.toml'
alias qtl='cd ~/.dotfiles/qtile && nvim ~/.dotfiles/qtile/config.py'
alias v='nvim'
alias v.='nvim .'
alias zlj='cd ~/.dotfiles/zellij && nvim ~/.dotfiles/zellij/config.kdl'
alias tmx='cd ~/.dotfiles/tmux && nvim ~/.dotfiles/tmux/.tmux.conf'
alias back='cd -'
alias di='docker images'
alias bsh='cd ~/.dotfiles/bash/ && nvim .bashrc'
alias ble='cd ~/.dotfiles/bash/ && nvim .blerc'
alias mstart='minikube start'
alias mstatus='minikube status'
alias k='kubectl'
alias kdescribe='kubectl describe'
alias kapply='kubectl apply'
alias rm_untagged='docker rm $(docker ps -a -q -f "status=exited") && docker rmi $(docker images -f "dangling=true" -q)'
alias console='sudo -u postgres psql'
alias run='nim c -r'
alias compile='nim c -d:release'
# alias rm=''
alias rf='rm -rf'
alias md='mkdir -p'
alias s='source $HOME/.dotfiles/zsh/.zshrc'
alias ve='source ./venv/bin/activate && nvim .'
alias st='tmux source-file'
alias menv='python3 -m venv ./venv'
alias senv='source ./venv/bin/activate'
alias denv='deactivate'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='sudo systemctl status'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
alias sdi='sudo dnf install'
alias sdrm='sudo dnf remove'
alias sdri='sudo dnf reinstall'
alias sdur='sudo dnf update --refresh'
alias tpla='tmuxp load /home/wurfkreuz/.tmux_layouts/ansible_layout.yml'
alias tplgp='tmuxp load /home/wurfkreuz/.tmux_layouts/go_py_layout.yml'
alias ssh-DO='ssh -i /home/wurfkreuz/.ssh/DOw wurfkreuz@209.38.196.169'
alias ap='ansible-playbook'
alias apK='ansible-playbook -K'
alias channels='nix-channel --update home-manager'
alias search='nix-env -qa'
alias switch='home-manager switch'
alias e='sudo -e'
alias home='nvim /home/wurfkreuz/.dotfiles/home-manager/home.nix'
alias zsh='cd $HOME/.dotfiles/zsh/ && nvim .zshrc'
alias ls='exa'
alias sl='exa'
alias la='exa -lah'
alias ld='exa -ld'
alias ls.='exa -a | grep -E "^\."'
alias tree='exa -T'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# alias push='git add . && git commit -m "n" && git push'
alias g='git'
alias notes='nvim "$HOME/notes.txt"'
alias backup='sudo timeshift --create --comments'
alias ff='rg --files | fzf'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias nvm='cd ~/.dotfiles/nvim/ && nvim .'
alias install='sudo pacman -Syu'
alias remove='sudo pacman -R'
alias orphaned='sudo pacman -Qtdq'
alias hello='echo "Hello"'
alias inpt='cd $HOME/.dotfiles/bash && nvim .inputrc'

# bindkey '^R' fzf_history_search

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

eval "$(zoxide init zsh)"

source ~/.dotfiles/zsh/functions.sh

(nohup gitlab-runner run &> /dev/null &)
# source $HOME/.dotfiles/zsh/config_variables/flashcards_bot

KEYTIMEOUT=1
function zle-line-init zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ;
    then echo -ne '\e[2 q'
    else echo -ne '\e[6 q'
    fi
}
zle -N zle-line-init
zle -N zle-keymap-select

stty -ixon

bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^L' clear-screen
# bindkey -r "^R"
# bindkey "^R" history-incremental-search-backward
# bindkey "^S" history-incremental-search-forward

insert-last-word-widget() {
  LBUFFER=${LBUFFER}${(z)$(fc -ln -1)[2,-1]}
}
zle -N insert-last-word-widget
bindkey -M viins '\e.' insert-last-word-widget
bindkey -M vicmd '\e.' insert-last-word-widget

# # Left and right side prompts
# setopt PROMPT_SUBST
# # PROMPT='%1~ > '
# # RPROMPT='%1~'
# RPROMPT='$(echo $(basename $(dirname $PWD))/$(basename $PWD))'

# source '/home/wurfkreuz/.source/antigen/antigen.zsh'
source '/home/wurfkreuz/antigen.zsh'

antigen bundle marlonrichert/zsh-autocomplete &> /dev/null
antigen bundle zsh-users/zsh-syntax-highlighting &> /dev/null
antigen apply &> /dev/null

# for the autocomplete plugin
zstyle ':autocomplete:*' ignored-input '##'
# bindkey -r "^R"
# bindkey "^R" history-incremental-pattern-search-backward
# bindkey '^R' history-incremental-search-backward

swww init 2> /dev/null
swww img "$HOME/Downloads/pictures/68747470733a2f2f692e696d6775722e636f6d2f4c65756836776d2e676966.gif"

eval "$(starship init zsh)"

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval "$(ssh-agent -s)" 1> /dev/null
fi
SSH_KEY_DIR="$HOME/.ssh/keys"
for key in "$SSH_KEY_DIR"/*; do
    if [[ -f $key && ! $key =~ \.pub$ ]]; then # The '=~' part is for making a regular expression check. The slash is an escape sequence because a dot has its own meaning for regular expressions.
        ssh-add "$key" > /dev/null 2>&1 
    fi
done

function preexec() {
  if mountpoint -q ~/.remote; then
      fusermount -u ~/.remote
  fi
}

