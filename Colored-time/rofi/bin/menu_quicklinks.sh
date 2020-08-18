#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/menu/quicklinks.rasi"

# Links
google=""
facebook=""
twitter=""
github=""
reddit=""
youtube=""

# Variable passed to rofi
options="$google\n$facebook\n$twitter\n$github\n$reddit\n$youtube"

chosen="$(echo -e "$options" | $rofi_command -p "Open In : Firefox Nightly" -dmenu -selected-row 0)"
case $chosen in
    $google)
        firefox-trunk --new-tab https://www.google.com
        ;;
    $facebook)
        firefox-trunk --new-tab https://erie.collin.edu/cas-web/login?service=https%3A%2F%2Fcougarweb.collin.edu%2Fc%2Fportal%2Flogin
        ;;
    $twitter)
        firefox-trunk --new-tab https://mail.zoho.com/zm/#mail/folder/inbox
        ;;
    $github)
        firefox-trunk --new-tab https://www.github.com
        ;;
    $reddit)
        firefox-trunk --new-tab https://www.reddit.com
        ;;
    $youtube)
        firefox-trunk --new-tab https://www.youtube.com
        ;;
esac

