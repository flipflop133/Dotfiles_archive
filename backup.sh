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
echo "DOT BACKUP"|lolcat || echo -e echo -e "\e[96mDOT BACKUP\e[0m"

# define backup directory
echo -e "\e[96mBackup directory:\e[0m"
pwd=$(pwd)
echo "$pwd"
dot=$pwd

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

# clean old dotfiles
cleaner(){
    read -r -p "Clean old dotfiles(those in the cloned repo)? [y/N]" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo -e "\e[96mOld dotfiles will be deleted.\e[0m" 
        clean="true"
    else
        echo -e "\e[96mSkipping cleaning.\e[0m" 
    fi
}

# backup files
backup(){
    # Set IFS to '' so spaces are not ignored
	IFS=''
    # copy dot files to backup directory
    echo -e "\e[96mBackuping the following dotfiles:\e[0m"
    # clean old dotfiles
    if [ "$clean" = "true" ]
    then rm -rf $dot/dotfiles
    fi
    # backup new dotfiles
    mkdir $dot/dotfiles
    for dir in ${directories[@]}; do
        echo "$dir"
        # copy the dotfile
        cp -R -f "$dir" $dot/dotfiles
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

# execute the functions
cleaner
backup
backup_app
git
echo -e "\e[96mBackup completed!\e[0m"
