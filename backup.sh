#!/bin/bash

###################################################################
#  _____   ____ _______   ____          _____ _  ___    _ _____   #
# |  __ \ / __ \__   __| |  _ \   /\   / ____| |/ / |  | |  __ \  #
# | |  | | |  | | | |    | |_) | /  \ | |    | ' /| |  | | |__) | #
# | |  | | |  | | | |    |  _ < / /\ \| |    |  < | |  | |  ___/  #
# | |__| | |__| | | |    | |_) / ____ \ |____| . \| |__| | |      #
# |_____/ \____/  |_|    |____/_/    \_\_____|_|\_\\____/|_|      #
###################################################################

# Display title
clear
figlet DOT BACKUP|lolcat || echo -e echo -e "\e[96mDOT BACKUP\e[0m"

# define backup directory
dot=~/dot_files

# dot files directories
directories=(
    ~/.config/i3
    ~/.zshrc
    ~/.config/rofi
    ~/.config/conky
    ~/.config/picom
    ~/.config/termite
)

# backup files
backup(){
    # copy dot files to backup directory
    echo -e "\e[96mCopying files...\e[0m"
    for dir in ${directories[@]}; do
        cp -R -f $dir $dot
    done
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