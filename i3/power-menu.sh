#!/usr/bin/env bash

_rofi() {
  rofi -sep '|' -columns 6 -lines 1 -disable-history true -cycle true \
    -theme menu\
    -dmenu -font "Hack Nerd Font 15" "$@"
}

choice=$(echo -n "|||||" | _rofi -mesg "<span face='ClearSans' font='9' weight='bold'>Goodbye, François 🙋‍♂️!</span>")

case "$choice" in
  )
    betterlockscreen -l
    ;;
  )
    ~/.bin/displaysleep
    ;;
  )
    systemctl suspend
    ;;
  )
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='ClearSans' font='9' weight='bold'>Logging out. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      i3-msg exit
    fi
    ;;
  )
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='ClearSans' font='9' weight='bold'>Rebooting. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      systemctl reboot
    fi
    ;;
  )
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='ClearSans' font='9' weight='bold'>Powering off. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      systemctl poweroff
    fi
    ;;
esac
