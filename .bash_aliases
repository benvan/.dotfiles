alias la='ls -A'

alias emacs='emacs -nw'
alias def='vim ~/.bashrc'
alias defem='emacs ~/.emacs'
alias defmod='vim ~/.xmonad/xmonad.hs'

alias usage='du -s * .[a-zA-Z]* | sort -n'

alias ai='sudo apt-get install'

alias pdf='pdfopen --file '

alias mktags='cd $CODEDIR && etags `find $CODEDIR -name "*.[h|c]"` && cd -'
alias lock='xlock -mode anemone -info "Back in a moment"'

alias o='gnome-open'
alias setbackground='sudo -u gdm gconftool-2 --set --type string --set /desktop/gnome/background/picture_filename'
alias o='gnome-open'
alias mule='(cd /tmp; mule)'

files(){ #alias
  find . -name "*.$1"
}

alias cb="tr -d '\n' | xclip -sel clip"
alias gp='cd /home/bene/dev-projects/global-platform/trunk'
alias qmvn='mvn -o -Dmaven.test.skip -P\!checkers'
alias mvno='mvn -o'

