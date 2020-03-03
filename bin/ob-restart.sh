#!/bin/bash

wal -i /home/ma/pics/wallpapers/
openbox --restart
pkill dunst
dunst -conf ~/.config/dunst/ob-dunstrc
pkill tint2
tint2