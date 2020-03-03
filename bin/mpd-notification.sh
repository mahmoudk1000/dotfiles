#!/bin/bash

musicdir="/home/ma/music"
song=$(mpc -f %file% | head -1)
trap "kill $$" SIGINT

#extract art

rm /tmp/cover
ffmpeg -i "$musicdir/$song" /tmp/cover.png
mv /tmp/cover.png /tmp/cover

notify-send -i /tmp/cover "$(mpc current -f "[%artist%\n %title%]")"

while [ "$song" >/dev/null ]; do
	notify-send -i /tmp/cover "$(mpc current -f "[%artist%\n %title%]" --wait)"
done