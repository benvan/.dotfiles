#!/bin/sh
#!/usr/bin/env bash

#----- settings -----#

xrdb -load ~/.Xdefaults &
xsetroot -cursor_name left_ptr &

#----- startup applications ----- #
xcompmgr &
conky -c $HOME/.conky/conkyrc_HUD &
feh --bg-center ~/Photos/backgrounds/background.jpg &

#system console - fully transparent, xmonad will move to sys workspace
urxvt -bg rgba:0000/0000/0000/0000 -name "sysConsole" &

setxkbmap -option caps:hyper
xmodmap -e 'remove mod4 = Hyper_L' && xmodmap -e 'add mod3 = Hyper_L'

xmonad
