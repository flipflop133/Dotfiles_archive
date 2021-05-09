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
	$colors;
}

options() {
	printf " save\n copy"
}

subOptions(){
	printf " active\n screen\n output\n麗 area\n window\n"
}

select=$(options | menu)
choice=""

case $select in
	" save")
		choice="save"
		echo "save selected"
		subSelect=$(subOptions | menu)
		;;
	" copy")
		choice="copy"
		echo "copy selected"
		subSelect=$(subOptions | menu)
		;;
	*)
		exit 1
esac


secondChoice=""

case $subSelect in
	" active")
		secondChoice="active"
		;;
	" screen")
		secondChoice="screen"
		;;
	" output")
		secondChoice="output"
		;;
	"麗 area")
		secondChoice="area"
		;;
	" window")
		secondChoice="window"
		;;
	*)
		exit 1
esac

$HOME/.config/scripts/bash/grimshot.sh --notify $choice $secondChoice
