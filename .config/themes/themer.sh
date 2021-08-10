#!/bin/bash
# Automatically change the system theme in function of the sunrise and sunset.
lastChecked=-1
sunrise=600
sunset=1800

theme(){
	newTheme=${theme/$1/$2}
	# theme foot
	sed -i "s|${1}Theme|${2}Theme|g" "$HOME"/.config/foot/foot.ini
	# theme sway
	sed -i "s|${1}Theme|${2}Theme|g" "$HOME"/.config/sway/config
	sed -i "s|${1}Fuzzel|${2}Fuzzel|g" "$HOME"/.config/sway/config
	sed -i "s|wallpaper/${1}|wallpaper/${2}|g" "$HOME"/.config/sway/config
	sed -i "s|$3|$newTheme|g" "$HOME"/.config/sway/config
	sway reload 1> /dev/null
	python "$HOME"/.config/themes/themeSway.py "${1}"
	sway reload 1> /dev/null
	# theme bemenu
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenupower.sh
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenuscreenrecord.sh
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenuscreenshot.sh
	# theme ncmcpp	
	ncmcpp "$1"
	# theme mako
	mako "$1"
	# theme zathura
	sed -i "s|${1}Theme|${2}Theme|g" "$HOME"/.config/zathura/zathurarc
	# theme nvim
	sed -i "s/themeStyle = \"${1}\"/themeStyle = \"${2}\"/g" "$HOME"/.config/nvim/lua/plugins.lua
	nvim +PackerCompile +qall!
}

ncmcpp(){
	if [[ $1 = "light" ]];then
		sed -i 's/black/white/g' "$HOME"/.config/ncmpcpp/config
	else
		sed -i 's/white/black/g' "$HOME"/.config/ncmpcpp/config
	fi
}

mako(){
	makoPID=$(pidof mako)
	if [ -n "$makoPID" ];then
		pkill mako
		if [[ $1 = "light" ]];then
			sed -i 's/background-color=#f2f2f2/background-color=#212121/g' "$HOME"/.config/mako/config
			sed -i 's/text-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
			sed -i 's/border-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
		else

			sed -i 's/background-color=#212121/background-color=#f2f2f2/g' "$HOME"/.config/mako/config
			sed -i 's/text-color=#ffffff/text-color=#000000/g' "$HOME"/.config/mako/config
			sed -i 's/border-color=#ffffff/border-color=#000000/g' "$HOME"/.config/mako/config

		fi
		setsid mako &
	fi
}

main(){
	theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
	if [[ $lastChecked -ne $(date +%j) ]];then
		data=$(python "$HOME"/.config/themes/sunset_sunrise.py)
		sunrise=${data:2:4}
		sunset=${data:10:4}
		lastChecked=$(date +%j)
	fi
	if [[ $(("10#"$(date +%H%M))) -lt $(("10#"$sunrise)) || $(("10#"$(date +%H%M))) -gt $(("10#"$sunset)) ]];then
		if [[ $theme == *"light"* ]];then
			theme "light" "dark" "$theme"
		fi
	else
		if [[ $theme == *"dark"* ]];then
			theme "dark" "light" "$theme"
		fi
	fi
	sleep 5
	main
}
main
