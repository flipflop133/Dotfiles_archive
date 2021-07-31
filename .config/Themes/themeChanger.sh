#!/bin/bash
dark_mode(){
	sed -i 's/lightTheme/darkTheme/g' "$HOME"/.config/foot/foot.ini
	sed -i 's/lightTheme/darkTheme/g' "$HOME"/.config/sway/config
	sed -i 's/lightBemenu/darkBemenu/g' "$HOME"/.config/sway/config
	sed -i 's/wallpaper\/light/wallpaper\/dark/g' "$HOME"/.config/sway/config
	sed -i 's/lightBememu/darkBemenu/g' "$HOME"/.config/scripts/bash/bemenupower.sh
	sed -i 's/lightBememu/darkBemenu/g' "$HOME"/.config/scripts/bash/bemenuscreenrecord.sh
	sed -i 's/lightBememu/darkBemenu/g' "$HOME"/.config/scripts/bash/bemenuscreenshot.sh
	sed -i 's/vimix-light-laptop-doder/vimix-dark-laptop-doder/g' "$HOME"/.config/sway/config
	sway reload
	ncmcpp_dark
	waybar_dark
	mako_dark
	sed -i 's/themeStyle = "light"/themeStyle = "dark"/g' "$HOME"/.config/nvim/lua/plugins.lua
	nvim +PackerCompile +qall!
}

light_mode(){
	sed -i 's/darkTheme/lightTheme/g' "$HOME"/.config/foot/foot.ini
	sed -i 's/darkTheme/lightTheme/g' "$HOME"/.config/sway/config
	sed -i 's/darkBemenu/lightBemenu/g' "$HOME"/.config/sway/config
	sed -i 's/wallpaper\/dark/wallpaper\/light/g' "$HOME"/.config/sway/config
	sed -i 's/darkBemenu/lightBemenu/g' "$HOME"/.config/scripts/bash/bemenupower.sh
	sed -i 's/darkBemenu/lightBemenu/g' "$HOME"/.config/scripts/bash/bemenuscreenrecord.sh
	sed -i 's/darkBemenu/lightBemenu/g' "$HOME"/.config/scripts/bash/bemenuscreenshot.sh
	sed -i 's/vimix-dark-laptop-doder/vimix-light-laptop-doder/g' "$HOME"/.config/sway/config
	sway reload
	ncmcpp_light
	waybar_light
	mako_light
	sed -i 's/themeStyle = "dark"/themeStyle = "light"/g' "$HOME"/.config/nvim/lua/plugins.lua
	nvim +PackerCompile +qall!
}

waybar_light(){
	waybarPID=$(pidof waybar)
	if [ -n "$waybarPID" ];then
		pkill waybar
		sed -i 's/background: #1f2428/background: #ffffff/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: #fffffff/color: #000000/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: rgba(255, 255, 255, 0.38);/color: rgba(0, 0, 0, 0.38);/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: #eeeeee/color: #111111/g' "$HOME"/.config/waybar/style.css
		setsid waybar &
	fi
}

waybar_dark(){
	waybarPID=$(pidof waybar)
	if [ -n "$waybarPID" ];then
		pkill waybar
		sed -i 's/background: #ffffff/background: #1f2428/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: #0000000/color: #ffffff/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: rgba(0, 0, 0, 0.38);/color: rgba(255, 255, 255, 0.38);/g' "$HOME"/.config/waybar/style.css
		sed -i 's/color: #111111/color: #eeeeee/g' "$HOME"/.config/waybar/style.css
		setsid waybar &
	fi
}

ncmcpp_light(){
	sed -i 's/white/black/g' "$HOME"/.config/ncmpcpp/config
}

ncmcpp_dark(){
	sed -i 's/black/white/g' "$HOME"/.config/ncmpcpp/config
}

mako_light(){
	makoPID=$(pidof mako)
	if [ -n "$makoPID" ];then
		pkill mako
		sed -i 's/background-color=#1f2428/background-color=#ffffff/g' "$HOME"/.config/mako/config
		sed -i 's/text-color=#ffffff/text-color=#000000/g' "$HOME"/.config/mako/config
		sed -i 's/border-color=#ffffff/border-color=#000000/g' "$HOME"/.config/mako/config
		setsid mako &
	fi
}

mako_dark(){
	makoPID=$(pidof mako)
	if [ -n "$makoPID" ];then
		pkill mako
		sed -i 's/background-color=#ffffff/background-color=#1f2428/g' "$HOME"/.config/mako/config
		sed -i 's/text-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
		sed -i 's/border-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
		setsid mako &
	fi
}

lastChecked=-1
sunrise=0
sunset=0
main(){
	currentTheme=$(gsettings get org.gnome.desktop.interface gtk-theme)
	
	if [[ $lastChecked -ne $(date +%j) ]];then
		data=$(python sunset_sunrise.py)
		sunrise=${data:2:4}
		sunset=${data:10:4}
		lastChecked=$(date +%j)
	fi
	# Check AM or PM
	if [[ $(date +%p) == "AM" ]];then
		# If AM, check sunrise
		if [[ ($(date +%I%M) -lt $sunrise) ]];then
			if [[ $currentTheme == *"light"* ]];then
				dark_mode
			fi
		else
			if [[ $currentTheme == *"dark"* ]];then
				light_mode
			fi
		fi
	else
		# If PM, check sunset
		if [[ ($(date +%I%M) -gt $sunset) ]];then
			if [[ $currentTheme == *"light"* ]];then
				dark_mode
			fi
		else
			if [[ $currentTheme == *"dark"* ]];then
				echo works
				light_mode
			fi
		fi
	fi
	sleep 5m
	main
}
main
