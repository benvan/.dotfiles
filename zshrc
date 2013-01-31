# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="benvan"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

setopt interactivecomments
setopt rcquotes
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mvn cp files xlast)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

GP=/home/bene/dev-projects/global-platform/trunk
alias -g "??"='$(`history | tail -n1 | cut -c8-`)'
alias gitd='git svn dcommit'
alias gp='cd $GP'
alias ls='ls -l --color'
alias la='ls -A'
alias def='vim ~/.zshrc'
alias defmod='vim ~/.xmonad/xmonad.hs'
alias usage='du -s * .[a-zA-Z]* | sort -n'
alias o='thunar'
alias setbackground='sudo -u gdm gconftool-2 --set --type string --set /desktop/gnome/background/picture_filename'
alias cb="tr -d '\n' | xclip -sel clip"
alias mvn='mvn-color'
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers'
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers clean install'
alias mvno='mvn -o'
alias listall='compgen -c | sort -u'
alias sudo='sudo -E'
alias server='python -m SimpleHTTPServer'
alias grep='grep --color'



source $HOME/Installs/z/z.sh
