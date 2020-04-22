#!/bin/sh

# set important paths
export XDG_CONFIG_HOME="$HOME/.config"

[ -d /sbin ] && PATH="$PATH:/sbin"
[ -d /usr/sbin ] && PATH="$PATH:/usr/sbin"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# auto startx
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
