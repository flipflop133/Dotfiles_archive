#!/bin/bash
alacritty --hold -e $SHELL -c 'neofetch && $SHELL'  &
sleep 2
alacritty -e ytop &
sleep 1
i3-msg split v
sleep 1
alacritty & exit
