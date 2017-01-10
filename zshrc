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
setopt always_to_end

plugins=(jump git mvn cp files xlast npm)

source $ZSH/oh-my-zsh.sh

# invoke $PATH setup
source $HOME/.dotfiles/pather

# invoke sandboxd setup
source $HOME/.scripts/external/sandboxd/sandboxd

function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME/bin
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  echo REMOVING FROM PATH $1
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }
#setjdk 1.7

alias pu='git push -u origin $(current_branch)'
alias -g "??"='$(`history | tail -n1 | cut -c8-`)'
alias gitd='git svn dcommit'
alias gp='cd $GP'
alias ls='ls -l --color'
alias la='ls -A'
alias j='jump'
alias def='vim ~/.zshrc'
alias defpath='vim ~/.dotfiles/pathrc'
alias defmod='vim ~/.xmonad/xmonad.hs'
alias usage='du -s * ".[a-zA-Z]*" | sort -n'
alias o='thunar'
alias setbackground='sudo -u gdm gconftool-2 --set --type string --set /desktop/gnome/background/picture_filename'
alias cb="tr -d '\n' | xclip -sel clip"
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers'
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers clean install'
alias mvno='mvn -o'
alias listall='compgen -c | sort -u'
alias sudo='sudo -E'
alias server='python -m SimpleHTTPServer'
alias grep='grep --color'

export _JAVA_AWT_WM_NONREPARENTING=1
export NVM_DIR=~/.nvm
export TERM=rxvt

unsetopt share_history


ulimit -n 65536
#ulimit -u 2048

unsetopt correct_all
