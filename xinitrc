#!/usr/bin/env zsh

source ~/.dotfiles/pather

LOG=~/.xsession.log

#----- settings -----#
#caps lock used by xmonad as modm
xmodmap .xmodmaprc &
~/.scripts/fix_caps_lock &

xrdb -load ~/.Xdefaults &
xsetroot -cursor_name left_ptr &

#----- startup applications ----- #
xcompmgr &
conky -c $HOME/.conky/conkyrc_HUD &
feh --bg-center ~/.dotfiles/local/background_image &

exec xmonad 
