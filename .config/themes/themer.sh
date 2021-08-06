#!/bin/bash
theme(){
	# Retrieve current theme
	theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
	newTheme=${theme/$1/$2}
	# theme foot
	sed -i "s|${1}Theme|${2}Theme|g" "$HOME"/.config/foot/foot.ini
	# theme sway
	sed -i "s|${1}Theme|${2}Theme|g" "$HOME"/.config/sway/config
	sed -i "s|${1}Fuzzel|${2}Fuzzel|g" "$HOME"/.config/sway/config
	sed -i "s|wallpaper/${1}|wallpaper/${2}|g" "$HOME"/.config/sway/config
	sed -i "s|$theme|$newTheme|g" "$HOME"/.config/sway/config
	sway reload 1> /dev/null
	python $HOME/.config/themes/themeSway.py ${1}
	sway reload 1> /dev/null
	# theme bemenu
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenupower.sh
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenuscreenrecord.sh
	sed -i "s|${1}Bemenu|${2}Bemenu|g" "$HOME"/.config/scripts/bash/bemenuscreenshot.sh
	# theme ncmcpp	
	ncmcpp "$1"
	# theme mako
	mako "$1"
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
			sed -i 's/background-color=#ffffff/background-color=#1f2428/g' "$HOME"/.config/mako/config
			sed -i 's/text-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
			sed -i 's/border-color=#000000/text-color=#ffffff/g' "$HOME"/.config/mako/config
		else

			sed -i 's/background-color=#1f2428/background-color=#ffffff/g' "$HOME"/.config/mako/config
			sed -i 's/text-color=#ffffff/text-color=#000000/g' "$HOME"/.config/mako/config
			sed -i 's/border-color=#ffffff/border-color=#000000/g' "$HOME"/.config/mako/config

		fi
		setsid mako &
	fi
}

lastChecked=-1
sunrise=0
sunset=0
main(){
	currentTheme=$(gsettings get org.gnome.desktop.interface gtk-theme)
	if [[ $lastChecked -ne $(date +%j) ]];then
		data=$(python $HOME/.config/themes/sunset_sunrise.py)
		sunrise=${data:2:4}
		sunset=${data:10:4}
		lastChecked=$(date +%j)
	fi

	if [[ $(("10#"$(date +%H%M))) -lt $(("10#"$sunrise)) || $(("10#"$(date +%H%M))) -gt $(("10#"$sunset)) ]];then
		if [[ $currentTheme == *"light"* ]];then
			theme "light" "dark"
		fi
	else
		if [[ $currentTheme == *"dark"* ]];then
			theme "dark" "light"
		fi
	fi
	sleep 5m
	main
}
main
