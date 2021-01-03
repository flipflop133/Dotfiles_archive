#!/bin/bash

# Dependencies: light, Pulseaudio-ctl, Papirus icon pack

brightness(){
	icon_path="/usr/share/icons/Papirus/48x48/status/"
	brightness_low="notification-display-brightness-low.svg"
	brightness_medium="notification-display-brightness-medium.svg"
	brightness_high="notification-display-brightness-high.svg"
	brightness_full="notification-display-brightness-full.svg"

	brightness=$(light)
	brightness=${brightness%.*}

	# Set the icon depending on the brightness level
	if [ "$brightness" -lt 34 ]; then
		icon=$icon_path$brightness_low
	elif [ "$brightness" -lt 67 ]; then
		icon=$icon_path$brightness_medium
	elif [ "$brightness" -lt 100 ]; then
		icon=$icon_path$brightness_high
	else
		icon=$icon_path$brightness_full
	fi

	# Send the notification
	dunstify -h string:x-canonical-private-synchronous:brightness "Brightness [$brightness] " -h int:value:"$brightness" --icon $icon
}
volume(){
	icon_path="/usr/share/icons/Papirus/48x48/status/"
	volume_low="notification-audio-volume-low.svg"
	volume_medium="notification-audio-volume-medium.svg"
	volume_high="notification-audio-volume-high.svg"

	sleep 0.1 # This gives time to get accurate status
	volume=$(pamixer --get-volume)

	# Set the icon depending on the volume level
	if [ $volume -lt 34 ]; then
		icon=$icon_path$volume_low
	elif [ $volume -lt 67 ]; then
		icon=$icon_path$volume_medium
	else
		icon=$icon_path$volume_high
	fi

	# Send the notification
	dunstify -h string:x-canonical-private-synchronous:audio "Volume" "$volume%" -h int:value:"$volume" --icon $icon
}
mute(){
	icon_path="/usr/share/icons/Papirus/48x48/status/"
	volume_muted="notification-audio-volume-muted.svg"
	mute_status=$(pamixer --get-mute)
	if [ "$mute_status" = "true" ]; then
		icon=$icon_path$volume_muted
		level="muted"
	else
		volume
		exit
	fi
	# Send the notification
	dunstify -h string:x-canonical-private-synchronous:audio "Volume" "Muted" -h int:value:"$volume" --icon $icon
}
microphone(){
	icon_path="/usr/share/icons/Papirus/48x48/status/"
	mic_off="mic-off.svg"
	mic_on="mic-ready.svg"

	sleep 0.1 # This gives time to get accurate mute status
	status=$(pamixer --source 5 --get-mute)

	# Set the icon depending on the volume level
	if [ "$status" = "true" ]; then
		icon=$icon_path$mic_off
		micro="muted"
	else
		icon=$icon_path$mic_on
		micro="unmuted"
	fi

	# Send the notification
	dunstify -h string:x-canonical-private-synchronous:microphone "Microphone status" "$micro" --icon $icon
}
case "$1" in
	microphone)
		microphone
		;;
	volume)
		volume
		;;
	mute)
		mute
		;;
	brightness)
		brightness
		;;
esac
