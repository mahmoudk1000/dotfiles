#!/bin/sh

# Autostart
compton --config ~/.config/compton.conf &
setxkbmap -model pc105 -layout us,ru,ua -option grp:ctrl_alt_toggle &
dunst -conf ~/.config/dunst/dwm-dunstrc &
notify-send "$(~/scripts/greeting.sh)" &
mpd &
~/scripts/updates.sh &

# Bar
dte(){
	dte="$(date +"%H:%M")"
	echo -e " $dte "
}

upd(){
	upd="$(checkupdates | wc -l)"
	echo -e " $upd "
}

spotify(){
	spotify="$(python /home/ma/scripts/polybar/spotify_status.py -f '  {artist} - {song}')"
	echo -e "$spotify "
}

weather(){
	weather="$(curl wttr.in/Voznesensk?format="+%t")"
	echo -e "$weather"
}

alsa () {
    alsa="$(amixer get Master | grep -o "[0-9]*%")"
    echo -e " $alsa "
}

mpd () {
	mpd="$(mpc current --format " %artist% - %title%")"
	echo -e " $mpd "
}

while true; do
	xsetroot -name "$(mpd) $(alsa) $(upd) $(dte)"
	sleep 1m #update time
done &
