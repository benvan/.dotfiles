# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="benvan"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

setopt interactivecomments
setopt rcquotes
setopt nohup

# don't cache commands!
zstyle ":completion:*:commands" rehash 1

plugins=(git mvn cp files xlast npm)

source $ZSH/oh-my-zsh.sh

# invoke $PATH setup
source $HOME/.dotfiles/pather

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

export _JAVA_AWT_WM_NONREPARENTING=1

source $HOME/.dotfiles/z-zsh/z.sh

