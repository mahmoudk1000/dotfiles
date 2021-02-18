#!/bin/env sh

pkill polybar

sleep 1;

polybar middle &
polybar right &
polybar left &
