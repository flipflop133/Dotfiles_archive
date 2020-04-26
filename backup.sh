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
    echo "Copying files..."
    echo -e "\e[96mCopying files...\e[0m"
    for dir in ${directories[@]}; do
        cp -R -f $dir $dot
    done
}

# push files to github
GIT=`which git`
git(){
    ${GIT} add .
    ${GIT} commit -m "update dotfiles"
    ${GIT} push
}

backup && git && echo -e "\e[96mBackup completed!\e[0m"
