#!/bin/bash

chosen=$(echo -e "lock\nlogout\nshutdown\nreboot\nsuspend\nhibernate" | rofi -dmenu -lines 6 -width 8 -p "shutdown" -i)

if [[ $chosen = "lock" ]]; then
	~/scripts/lock.sh
elif [[ $chosen = "logout" ]]; then
	 openbox --exit
elif [[ $chosen = "shutdown" ]]; then
	systemctl poweroffq
elif [[ $chosen = "reboot" ]]; then
	systemctl reboot
elif [[ $chosen = "suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "hibernate" ]]; then
	systemctl hibernate
fi