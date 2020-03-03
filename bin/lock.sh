#!/bin/bash

#scrot /tmp/screen.png
#convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
#[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
#mpc stop
#i3lock -u -i /tmp/screen.png
#rm /tmp/screen.png

scrot /tmp/screen.png
#convert /tmp/screen.png -blur 0x8 /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.mpv /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
mpc pause

pkill -u $USER -USR1 dunst
i3lock -n -i /tmp/screen.png \
    --insidecolor=37344500 --ringcolor=f2f2f2ff --line-uses-inside \
    --keyhlcolor=6ec480ff --bshlcolor=d23c3dff --separatorcolor=00000000 \
    --insidevercolor=96cbffff --insidewrongcolor=d23c3dff \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+60:y+993" \
    --radius=15 --veriftext="" --wrongtext=""
pkill -u $USER -USR2 dunst
mpc play
rm /tmp/screen.png
