if [[ -n "$PS1" ]] ; then

    HISTCONTROL=ignoredups:ignorespace
    shopt -s histappend
    HISTSIZE=10000
    HISTFILESIZE=20000
    shopt -s checkwinsize
    bind "set match-hidden-files off"


    if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
    else
        export TERM='xterm-color'
    fi

# make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

# set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac


    export JDK_HOME=/usr/lib/jvm/java-6-openjdk
    export JREBEL_PATH=/home/ben/Installs/JRebel/jrebel.jar
    export IDEA_JDK=/usr/lib/jvm/java-6-sun
    export PATH=$PATH:/opt:/opt/scala-2.9.1.final/bin:~/.scripts:$JDK_HOME/bin:~/Installs


# If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
    esac

# enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls -lhF --color=auto'
        alias sl=ls
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi


    EDITOR=/usr/local/bin/vim

    if [ "$DISPLAY" ]; then
        ptsadd
        xset b off
    fi

__git_ps1_(){
  [[ $PWD != $HOME ]] && __git_ps1 $1
}

export PS1="\[\033[38;5;75m\]\
[\[\033[32m\]\
\W\[\033[38;5;75m\]]\
\$(__git_ps1_ \"\[\033[33m\](%s)\")\
\[\033]0;\W\007\\]\
\[\033[38;5;75m\]\
$ \[\e[m\]"


    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    stty -echoctl

    [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
    #auto-load rails3
    #rvm use 1.9.2@rails3 --default
fi
