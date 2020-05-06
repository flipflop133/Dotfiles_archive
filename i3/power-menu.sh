#!/usr/bin/env bash

_rofi() {
  rofi -sep '|' -columns 6 -lines 1 -disable-history true -cycle true \
    -theme menu\
    -dmenu -font "Noto Sans Nerd Font Medium 11" "$@"
}

choice=$(echo -n " Lock| Hibernate| Sleep| Logout| Restart| Poweroff" | _rofi -mesg "<span face='NotoSans' font='9' weight='bold'>Goodbye, François 🙋‍♂️!</span>")

case "$choice" in
  " Lock")
    betterlockscreen -l
    ;;
  " Hibernate")
    systemctl hibernate
    ;;
  " Sleep")
    systemctl suspend
    ;;
  " Logout")
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='NotoSans' font='9' weight='bold'>Logging out. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      i3-msg exit
    fi
    ;;
  " Restart")
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='NotoSans' font='9' weight='bold'>Rebooting. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      systemctl reboot
    fi
    ;;
  " Poweroff")
    choice=$(echo -n "No|Yes" | _rofi -mesg "<span face='NotoSans' font='9' weight='bold'>Powering off. Are you sure?</span>")
    if [ "$choice" = "Yes" ]; then
      systemctl poweroff
    fi
    ;;
esac
