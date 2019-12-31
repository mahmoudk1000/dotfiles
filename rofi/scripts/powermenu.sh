#!/bin/bash

# options to be displayed
option0="lock"
option1="suspend"
option2="scheduled suspend (10min)"
option3="scheduled suspend (20min)"
option4="scheduled suspend (30min)"
option5="reboot"
option6="shutdown"

# options passed into variable
options="$option0\n$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

chosen="$(echo -e "$options" | rofi -lines 8 -dmenu -p "power")"
case $chosen in
    $option0)
        i3lock;;
    $option1)
        systemctl suspend;;
	$option2)
		sleep 600 && systemctl suspend;;
	$option3)
		sleep 1200 && systemctl suspend;;
	$option4)
		sleep 1800 && systemctl suspend;;
    $option5)
        systemctl reboot;;
	$option6)
        systemctl poweroff;;
esac
