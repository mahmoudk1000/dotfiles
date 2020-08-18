#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/menu/backlight.rasi"

## Get Brightness
VAR="$(xbacklight -get)"
BLIGHT="$(printf "%.0f\n" "$VAR")"

if [[ $BLIGHT -ge 1 ]] && [[ $BLIGHT -le 29 ]]; then
    MSG="Low"
elif [[ $BLIGHT -ge 30 ]] && [[ $BLIGHT -le 49 ]]; then
    MSG="Optimal"
elif [[ $BLIGHT -ge 50 ]] && [[ $BLIGHT -le 69 ]]; then
    MSG="High"
elif [[ $BLIGHT -ge 70 ]] && [[ $BLIGHT -le 99 ]]; then
    MSG="Too Much"
fi

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_OPT=""

options="$ICON_UP\n$ICON_OPT\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BLIGHT%  :  $MSG" -dmenu -selected-row 1)"
case $chosen in
    $ICON_UP)
        xrandr --output HDMI-A-1 --brightness 1.0
        ;;
    $ICON_DOWN)
        xrandr --output HDMI-A-1 --brightness 0.5
        ;;
    $ICON_OPT)
        xrandr --output HDMI-A-1 --brightness 0.75
        ;;
esac

