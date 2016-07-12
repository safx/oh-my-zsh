export LANG=ja_JP.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="mytheme"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew autojump cabal docker gem git pod xcode)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt printexitvalue

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# Key bindings
#stty -istrip
#bindkey -e

# some settings
#FIGNORE=.BAK:.dvi:.aux:.toc:.log:.lof:.lot:.idx:.ind:.o:.class:.log:.orig
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# gulp
eval "$(gulp --completion=zsh)"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Go
#export GOROOT=/usr/local/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/dev/golang
export PATH="$GOROOT/bin:$PATH"


# Docker
export DOCKER_HOST=tcp://127.0.0.1:4243

# OCaml
. /Users/safx/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# activate autojump
autoload -U compinit && compinit

# aliases
alias m='make'
alias e='~/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait'
alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -a'
alias cp='cp -i'
alias ca=carthage
alias mv='mv -i'
alias rm='rm -i'
alias sl=ls
alias ssh='ssh -X'
alias od='od -t x1 -v'
alias l=less
alias lv=less
which md5sum > /dev/null && alias md5='md5sum'
alias unrar='~/unrar'
alias f='open -a Finder'
#alias hg='/Applications/SourceTree.app/Contents/Resources/mercurial_local/hg_local'
alias mp='$HOME/Applications/mpv.app/Contents/MacOS/mpv'
alias cv='$HOME/Applications/cooViewer.app/Contents/MacOS/cooViewer'
alias gob="$GOROOT/bin/go build -gcflags '-N -l'"

# git aliases
alias gd="git diff"
alias gds="git diff --staged"
#alias gg="git grep"
alias gl="git log"
alias gs="git status"

function a {
    local sel="$(ag $@ | peco)"
    local xs
    if [ ! -z "$sel" ] ; then
        xs=("${(@s/:/)sel}")  # splitt with `:`
        echo "$xs[1]"
        e "$xs[1]"
        e --eval "(with-current-buffer (window-buffer (selected-window)) (goto-line $xs[2]))"
    fi
}

function gg {
    local sel="$(git grep -n $@ | peco)"
    local xs
    if [ ! -z "$sel" ] ; then
        xs=("${(@s/:/)sel}")  # splitt with `:`
        echo "$xs[1]"
        e "$xs[1]"
        e --eval "(with-current-buffer (window-buffer (selected-window)) (goto-line $xs[2]))"
    fi
}

function ff {
    local file="$(find . -type f \! -iwholename '*/.git/*' -and -name \*$1\* | cut -c 3- | peco --select-1 --initial-index 1 | awk -F: '{print $1}')"
    if [ ! -z "$file" ] ; then
        echo "$file"
        e "$file"
    fi
}

function cdd {
    local dir=$(find . -type d \! -iwholename '*/.git/*' -and \! -name . | cut -c 3- | peco --select-1 --initial-index 1 | awk -F: '{print $1}')
    if [ ! -z "$dir" ] ; then
        cd "$dir"
        cd "$dir"
    fi
}

function sshh {
    local host=$(grep "Host " ~/.ssh/config | grep -v '*' | cut -b 6- | peco)
    if [ -n "$host" ]; then
        cd "$host"
        ssh "$host"
    fi
}

source ~/.zshrc.local
