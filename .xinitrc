#!/bin/sh
#!/usr/bin/env bash

LOG=~/.xsession.log


#----- settings -----#
#caps lock used by xmonad as modm
xmodmap .xmodmaprc

xrdb -load ~/.Xdefaults &
xsetroot -cursor_name left_ptr &

#----- startup applications ----- #
xcompmgr &
conky -c $HOME/.conky/conkyrc_HUD &
feh --bg-center ~/Photos/backgrounds/background.jpg &

#system console - fully transparent, xmonad will move to sys workspace
urxvt -bg rgba:0000/0000/0000/0000 -name "sysConsole" &



exec xmonad
