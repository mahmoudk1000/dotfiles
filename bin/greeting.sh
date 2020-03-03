#!/bin/bash

TIME=$(date "+%H")

#sleep 5s
if [ $TIME -lt 05 ]; then
	echo "good night"
elif [ $TIME -lt 12 ]; then
	echo "good morning"
elif [ $TIME -lt 16 ]; then
	echo "good afternoon"
elif [ $TIME -lt 21 ]; then
	echo "good evening"
#elif [ $TIME -lt 23 ]; then
#	echo "good night"
fi
