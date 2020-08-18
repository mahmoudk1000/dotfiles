#!/bin/sh

# this file is run when calling startx

# default arch init scripts
if [ -d /etc/X11/xinit/.zinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -r /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -r ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -r ~/.zprofile ] && . ~/.zprofile

# lock the screen (no, i wont just use a display manager)
betterlockscreen -l

# auto start
nitrogen --restore; sleep 1 &
picom -b &
xfce4-power-manager &
mpd &
setxkbmap -model pc104 -layout us,ara -variant ,, -option grp:alt_shift_toggle &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
unclutter &
nm-applet &
# sxhkd &

# natural scrolling
xinput --set-prop 15 "libinput Natural Scrolling Enabled" 1 &

# launch the session, commands below this line will be ignored
exec dbus-launch i3
# exec yaxwm
