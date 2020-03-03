#!/bin/bash

chosen=$(echo -e "fullscreen\narea\narea [clipboard]\nactive window" | rofi -dmenu -lines 4 -width 10 -p "screenshot" -i)

if [[ $chosen = "fullscreen" ]]; then
	sleep 1; scrot '%F_%T_scrot.png' -e 'mv $f ~/screenshots/'; notify-send '	screenshot saved!'
elif [[ $chosen = "area" ]]; then
	maim -s ~/screenshots/$(date "+%F-%H-%M-%S").png; notify-send '	selected area screenshot saved!'
elif [[ $chosen = "area [clipboard]" ]]; then
	maim -s | xclip -selection clipboard -t image/png; notify-send '	screenshot copied to clipboard'
elif [[ $chosen = "active window" ]]; then
	sleep 1; scrot -u -b '%F_%T_scrot.png' -e 'mv $f ~/screenshots/'; notify-send '	active window screenshot saved!'
fi