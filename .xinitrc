#!/bin/sh
#!/usr/bin/env bash

#----- settings -----#
#caps lock used by xmonad as modm
xmodmap -e 'clear Lock' && xmodmap -e 'add Mod3 = Caps_Lock' &
xsetroot -cursor_name left_ptr &

#----- startup applications ----- #
xcompmgr &
conky -c /home/ben/.conky/conkyrc_HUD &
feh --bg-center ~/Photos/backgrounds/1255131532204.jpg &

#system console - fully transparent, xmonad will move to sys workspace
rxvt-unicode -bg rgba:0000/0000/0000/0000 -name "sysConsole" &



xmonad
