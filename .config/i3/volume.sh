# Dependencies:
# Pulseaudio-ctl
# Papirus icon pack
#!/bin/bash
icon_path="/usr/share/icons/Papirus-Light/16x16/actions/"
volume_low="audio-volume-low.svg"
volume_medium="audio-volume-medium.svg"
volume_high="audio-volume-high.svg"
volume_muted="audio-volume-muted.svg"

sleep 0.1 # This gives time to get accurate mute status 
volume=$(pulseaudio-ctl full-status)
volume=($volume)
level="${volume[0]}%"
mute_status=${volume[1]}

# Set the icon depending on the volume level
echo $mute_status
if [ $mute_status = "yes" ]; then
    icon=$icon_path$volume_muted
    level="muted"
    echo muted
elif [ $level -lt 34 ]; then
    icon=$icon_path$volume_low
elif [ $level -lt 66 ]; then
    icon=$icon_path$volume_medium
else
    icon=$icon_path$volume_high
fi

# Send the notification
dunstify -h string:x-canonical-private-synchronous:audio "Volume [$level] " -h int:value:"$level" --icon $icon 
