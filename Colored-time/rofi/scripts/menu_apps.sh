#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## browser : @adi1090x
## music : @adi1090x

rofi_command="rofi -theme themes/menu/apps.rasi"

# Links
terminal=""
files=""
editor=""
browser=""
music=""
settings="漣"

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
    $terminal)
        alacritty &
        ;;
    $files)
        discord &
        ;;
    $editor)
        alacritty -e vim &
        ;;
    $browser)
        firefox-trunk &
        ;;
    $music)
        alacritty -e ncmpcpp &
        ;;
    $settings)
        gedit ~/Documents/txt/passwords.txt &
        ;;
esac

