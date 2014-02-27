# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="mytheme"


# Example aliases
alias m='make'
alias e='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait'
alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -a'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias sl=ls
alias ssh='ssh -X'
alias od='od -t x1 -v'
alias lv=less
alias 7z='~/7z'
alias unrar='~/unrar'
alias f='open -a Finder'
alias hg='/Applications/SourceTree.app/Contents/Resources/mercurial_local/hg_local'
alias mp='/Applications/MPlayerX.app/Contents/Resources/binaries/x86_64/mplayer'
alias cv='$HOME/Applications/cooViewer.app/Contents/MacOS/cooViewer'

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
plugins=(brew autojump cabal docker git npm pod vagrant xcode)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
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

# Docker
export DOCKER_HOST=tcp://127.0.0.1:4243
