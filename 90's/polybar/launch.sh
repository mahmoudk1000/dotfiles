#!/bin/env sh

pkill polybar

sleep 1;

polybar top_bar &
polybar top_bar_ex &
polybar top &
