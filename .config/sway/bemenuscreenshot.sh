#!/bin/bash

font="RobotoMono 16"
colors="--fb=#ffffff
	--ff=#000000
	--tb=#ffffff
	--tf=#000000
	--nb=#ffffff
	--nf=#000000
	--hb=#000000
	--hf=#ffffff
	"

menu() { bemenu --fn "$font"\
	-i\
	-l 10\
	--prompt="ScreenshotMenu"\
	$colors; }

options() {
	printf "ﴖ save\n copy\n"
}

subOptions(){
	printf "active\nscreen\noutput\narea\nwindow\n"
}

select=$(options | menu)
choice=""

case $select in
	"ﴖ save")
		choice="save"
		subSelect=$(subOptions | menu)
		;;
	" copy")
		choice="copy"
		subSelect=$(subOptions | menu)
		;;
esac


secondChoice=""

case $subSelect in
	"active")
		secondChoice="active"
		;;
	"screen")
		secondChoice="screen"
		;;
	"output")
		secondChoice="output"
		;;
	"area")
		secondChoice="area"
		;;
	"window")
		secondChoice="window"
		;;
esac

$HOME/.config/sway/grimshot.sh --notify $choice $secondChoice
