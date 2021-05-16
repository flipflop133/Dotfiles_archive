#!/bin/sh
# Script to control notifications from status bar
# Dependency: mako

# Define active notification icon
icon="notifications"
iconActive=""
iconInactive=""

if [ "$1" = "--status" ];then
	if [ "$(pidof mako)" ];then
		icon=$iconActive
	else
		icon=$iconInactive
	fi
	echo "$icon"
elif [ "$1" = "--toggle" ];then
	if [ "$(pidof mako)" ];then
		killall mako
	else
		mako
	fi
fi

