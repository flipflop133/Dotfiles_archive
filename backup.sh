#!/bin/bash

###################################################################
#  _____   ____ _______   ____          _____ _  ___    _ _____   #
# |  __ \ / __ \__   __| |  _ \   /\   / ____| |/ / |  | |  __ \  #
# | |  | | |  | | | |    | |_) | /  \ | |    | ' /| |  | | |__) | #
# | |  | | |  | | | |    |  _ < / /\ \| |    |  < | |  | |  ___/  #
# | |__| | |__| | | |    | |_) / ____ \ |____| . \| |__| | |      #
# |_____/ \____/  |_|    |____/_/    \_\_____|_|\_\\____/|_|      #
###################################################################

# Save default IFS value
DefaultIFS=$IFS

# Display title
clear
figlet DOT BACKUP|lolcat || echo -e echo -e "\e[96mDOT BACKUP\e[0m"

# define backup directory
dot=~/dot_files

# dot files directories
directories=(
    $HOME/.zshrc
    $HOME/.config/alacritty
    "$HOME/.config/Code - OSS/User/settings.json"
    $HOME/.config/conky
    $HOME/.config/dunst
    $HOME/.config/fontconfig
    $HOME/.config/i3  
    $HOME/.config/picom
    $HOME/.config/polybar
    $HOME/.config/pythons-scripts
    $HOME/.config/rofi
)

# backup files
backup(){
    # Set IFS to '' so spaces are not ignored
	IFS=''
    # copy dot files to backup directory
    echo -e "\e[96mCopying files the following files:\e[0m"
    for dir in ${directories[@]}; do
        echo "$dir"
        cp -R -f "$dir" $dot
    done
    # Reset IFS to its default value
    IFS=$DefaultIFS
}

# backup list of installed packages
backup_app(){
    read -r -p "Backup explicitly installed app list? [y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "\e[96mDoing app list backup.\e[0m" 
        pacman -Qe > appList.txt
    else
        echo -e "\e[96mSkipping app list backup.\e[0m" 
    fi
}


# push files to github
GIT=`which git`
git(){
    ${GIT} add .
    ${GIT} commit -m "update dotfiles"
    ${GIT} push
}

backup && backup_app && git && echo -e "\e[96mBackup completed!\e[0m"
