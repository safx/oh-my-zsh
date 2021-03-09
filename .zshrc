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
export PATH=/usr/local/opt/openssl/bin:$PATH

# Key bindings
#stty -istrip
#bindkey -e

# some settings
#FIGNORE=.BAK:.dvi:.aux:.toc:.log:.lof:.lot:.idx:.ind:.o:.class:.log:.orig
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Go
#export GOROOT=/usr/local/opt/go/libexec
#export GOPATH=$HOME/src/go
#export GO111MODULE=on
#export PATH="$GOROOT/bin:$PATH"

# aliases
alias d='docker'
alias di='docker image'
alias dps='docker ps'
alias dm='docker-machine'
alias dc='docker-compose'
alias e='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait'
alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -a'
alias cp='cp -i'
alias c=cargo
alias mv='mv -i'
alias rm='rm -i'
alias sl=ls
alias ssh='ssh -X'
alias od='od -Ax -t x1 -v'
alias less=bat
which md5sum > /dev/null && alias md5='md5sum'
alias f='open -a Finder'
alias mp='$HOME/Applications/mpv.app/Contents/MacOS/mpv'
alias cv='$HOME/Applications/cooViewer.app/Contents/MacOS/cooViewer'
alias gifify='$HOME/.nodenv/versions/10.16.0/lib/node_modules/gifify/bin/gifify'
alias v=vagrant
alias aws-azure-login='aws-azure-login --no-prompt --all-profiles'

# git aliases
alias gl='git log'
alias gll='git log --graph --oneline'
alias gs='git status -s'
alias gt='git for-each-ref --sort=committerdate --format="%(committerdate:short) %(refname:short)" refs/tags'
alias gsp='git status -s | sk | cut -c 4- | pbcopy'
if ( where diff-so-fancy > /dev/null ) ; then
    alias gd="git diff --color | diff-so-fancy | \less -RFX"
    alias gds="git diff --staged --color | diff-so-fancy | \less -RFX"
else
    alias gd="git diff"
    alias gds="git diff --staged"
fi

alias ag=rg
function a {
    local sel xs cmd cmd2
    if [ -z "$1" ] ; then
        cmd="sk --ansi -i -c 'rg --color=always --line-number \"{}\"' --delimiter ':' --preview \"bat --plain --color=always {1} --highlight-line {2} | grep --color=always -e {cq} -e '$'\" --preview-window 25%"
    else
        cmd="rg --color=always --line-number $@ | sk --ansi --exact --delimiter ':' --preview \"bat --plain --color=always {1} --highlight-line {2} | grep --color=always -e \"$@\" -e '$'\" --preview-window 25%"
    fi
    eval $cmd | while read sel; do
        if [ ! -z "$sel" ] ; then
            xs=("${(@s/:/)sel}")  # splitt with `:`
            echo "$xs[1]"
            e "$xs[1]" && e --eval "(with-current-buffer (window-buffer (selected-window)) (goto-line $xs[2]))" > /dev/null
        fi
    done
}

alias gss > /dev/null && unalias gss
function gss {
    local xs sel
    git status -s | sed -e 's/^ /_/; s/^\(.\) /\1_/;' | sk -e --delimiter=' ' --preview='git diff {2} | diff-so-fancy --preview-window 25%' | cut -c 4- | while read sel; do
        if [ ! -z "$sel" ] ; then
            echo "$sel"
            e "$sel"
        fi
    done
}

alias gcb > /dev/null && unalias gcb
function gcb {
    local key name branch
    key=$1
    shift 1
    name=$(echo "$@" | sed -Ee 's|([^ ])([A-Z])|\1-\2|g; s| +|-|g; y/ABCDEFGHIJKLMNOPQRSTUVWXYZ./abcdefghijklmnopqrstuvwxyz-/; s|--|-|g;')
    branch=${key}/${name}
    echo $branch
    git checkout -b $branch
}

alias gbb > /dev/null && unalias gbb
function gbb {
    local branch=$(git branch --color=always | sk --ansi | cut -c 3-)
    if [ ! -z "$branch" ] ; then
        git checkout $branch
    fi
}

function ff {
    local cmd file
    if [ -z "$1" ] ; then
        cmd="sk --preview 'bat --plain --color=always {1}' --preview-window 25%"
    else
        cmd="find . -type f \! -iwholename '*/.git/*' -and -name \*$1\* | cut -c 3- | sk --preview 'bat --plain --color=always {1}' --preview-window 25%"
    fi
    eval $cmd | while read file; do
        if [ ! -z "$file" ] ; then
            echo "$file"
            e "$file"
        fi
    done
}

function cdd {
    local dir=$(sk --cmd-prompt='cd>' -i -c 'find . -type d -iname "*{}*"' --preview="exa --color=always {}" --preview-window 25%)
    if [ ! -z "$dir" ] ; then
        cd "$dir"
    fi
}

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

export RIPGREP_CONFIG_PATH=$HOME/.rg
export SKIM_DEFAULT_OPTIONS='--bind="ctrl-q:execute-silent(echo -n {1} | pbcopy)+abort,ctrl-k:kill-word,ctrl-d:delete-char,ctrl-w:backward-kill-word,f1:execute-silent(open -a \"Visual Studio Code\" {1})+abort,ctrl-v:page-down,ctrl-g:page-up,,alt-p:preview-up,alt-n:preview-down,f12:execute-silent(open -a Finder {1})+abort"'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

source $HOME/.config/broot/launcher/bash/br

# asdf
. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit
