# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

autoload -U colors
colors

setopt histignorealldups sharehistory
setopt noautomenu
setopt extendedglob
unsetopt correct_all

autoload select-word-style
select-word-style bash

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle -e ':completion:*' list-colors \
  'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[green]=$color[underline]" )'
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

_propdep_completion(){
  jars=(`find $HOME/.m2/repository/com/qatarlyst -name "*SNAPSHOT.jar"| while read x; do basename $x; done | \
         tr "\\n" " " | sed 's/ $//'`)
  reply=($jars)
}

compctl -K _propdep_completion propdep

gp=/home/bene/dev-projects/global-platform/trunk
alias -g "??"='$(`history | tail -n1 | cut -c8-`)'
alias gp='cd $gp'
alias ls='ls -l --color'
alias la='ls -A'
alias def='vim ~/.zshrc'
alias defmod='vim ~/.xmonad/xmonad.hs'
alias usage='du -s * .[a-zA-Z]* | sort -n'
alias o='thunar'
alias setbackground='sudo -u gdm gconftool-2 --set --type string --set /desktop/gnome/background/picture_filename'
alias cb="tr -d '\n' | xclip -sel clip"
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers'
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers clean install'
alias mvno='mvn -o'
alias listall='compgen -c | sort -u'
alias sudo='sudo -E'
alias server='python -m SimpleHTTPServer'


files(){ #alias
  while read ext; do
    find . -name "*.$ext"
  done < <(for i in $@; do echo $i; done)
}
PS1="%F{blue}[%F{green}%c%F{blue}]$ %f"
