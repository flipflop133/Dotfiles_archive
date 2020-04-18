#!/bin/bash

# install wmctrl. Its a prerequisite to make this script work.

# Launch it in your i3 config file
# exec --no-startup-id ~/.config/i3/startup_apps.sh

## WORKSPACE 2 UNIVERSITY ##
# Apps to start
apps=(	
 "thunderbird"
)

# Which workspace to assign your wanted App :
workspaces=(
"2:university"
)

# open the apps
for app in "${apps[@]}"
do
    i3-msg workspace ${workspaces} # move in wanted workspace
    exec $app & # start the wanted app
    sleep 3s
done

# wait a moment
sleep 4s

## WORKSPACE 3 SOCIAL ##
# Apps to start
apps=(	
 "discord"
 "telegram-desktop"
 "chromium https://www.messenger.com/"
 "chromium https://www.facebook.com/"
)

# Which workspace to assign your wanted App :
workspaces=(
"3:social"
)

# open the apps
for app in "${apps[@]}"
do
    i3-msg workspace ${workspaces} # move in wanted workspace
    exec $app & # start the wanted app
    sleep 3s
done

# wait a moment
sleep 4s

## WORKSPACE 4 MEDIA ##
# Apps to start
apps=(	
 "spotify"
)

# Which workspace to assign your wanted App :
workspaces=(
"4:media"
)

# open the apps
for app in "${apps[@]}"
do
    i3-msg workspace ${workspaces} # move in wanted workspace
    exec $app & # start the wanted app
    sleep 3s
done


# wait a moment
sleep 4s
