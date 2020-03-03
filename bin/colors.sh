#!/bin/sh
background=$(xrdb -query | grep "background" | cut -f2 | sed -r 's/#//' | head -n 1)
foreground=$(xrdb -query | grep "foreground" | cut -f2 | sed -r 's/#//' | head -n 1)
color0=$(xrdb -query | grep "color0" | cut -f2 | sed -r 's/#//' | head -n 1)
color1=$(xrdb -query | grep "color1" | cut -f2 | sed -r 's/#//' | head -n 1)
color2=$(xrdb -query | grep "color2" | cut -f2 | sed -r 's/#//' | head -n 1)
color3=$(xrdb -query | grep "color3" | cut -f2 | sed -r 's/#//' | head -n 1)
color4=$(xrdb -query | grep "color4" | cut -f2 | sed -r 's/#//' | head -n 1)
color5=$(xrdb -query | grep "color5" | cut -f2 | sed -r 's/#//' | head -n 1)
color6=$(xrdb -query | grep "color6" | cut -f2 | sed -r 's/#//' | head -n 1)
color7=$(xrdb -query | grep "color7" | cut -f2 | sed -r 's/#//' | head -n 1)
color8=$(xrdb -query | grep "color8" | cut -f2 | sed -r 's/#//' | head -n 1)
color9=$(xrdb -query | grep "color9" | cut -f2 | sed -r 's/#//' | head -n 1)
color10=$(xrdb -query | grep "color10" | cut -f2 | sed -r 's/#//' | head -n 1)
color11=$(xrdb -query | grep "color11" | cut -f2 | sed -r 's/#//' | head -n 1)
color12=$(xrdb -query | grep "color12" | cut -f2 | sed -r 's/#//' | head -n 1)
color13=$(xrdb -query | grep "color13" | cut -f2 | sed -r 's/#//' | head -n 1)
color14=$(xrdb -query | grep "color14" | cut -f2 | sed -r 's/#//' | head -n 1)
color15=$(xrdb -query | grep "color15" | cut -f2 | sed -r 's/#//' | head -n 1)

bspc config normal_border_color "#$color8"
bspc config active_border_color "#$color9"
bspc config focused_border_color "#$color9"
bspc config presel_feedback_color "#$color1"
#END
