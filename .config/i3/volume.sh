# dependencies
# ->pulseaudio-ctl
# ->libnotify-id
#!/bin/bash
icon_path="/usr/share/icons/Papirus-Light/16x16/actions/"
volume_low="audio-volume-low.svg"
volume_medium="audio-volume-medium.svg"
volume_high="audio-volume-high.svg"
volume_muted="audio-volume-muted.svg"
file_id="/tmp/notification_id.txt"

sleep 0.1 # this gives time to get accurate mute status 
volume=$(pulseaudio-ctl full-status)
volume=($volume)
level=${volume[0]}
mute_status=${volume[1]}

# set icon depending on volume level
echo $mute_status
if [ $mute_status = "yes" ]; then
    icon=$icon_path$volume_muted
    level="muted"
    echo muted
elif [ $level -lt 26 ]; then
    icon=$icon_path$volume_low
elif [ $level -lt 51 ]; then
    icon=$icon_path$volume_medium
else
    icon=$icon_path$volume_high
fi

bar=$(seq -s "━" 0 "$(($level / 6))" | sed 's/[0-9]//g') 
spaces=$(printf "%-30s" " ")

NID=$(<$file_id)
if [ -z $NID ]; then
    # send notification
    NID=$(notify-send --hint=int:transient:1 --icon=$icon -p -t 5000 -u "low" "Volume$spaces" "$level $bar" )
else
    # send notification
    NID=$(notify-send --hint=int:transient:1 --icon=$icon -p -t 5000 -u "low" -r $NID "Volume$spaces" "$level $bar")
fi
echo $NID > /tmp/notification_id.txt


