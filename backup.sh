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
figlet DOT BACKUP || echo "DOT BACKUP"

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
    for dir in ${directories[@]}; do
        cp -R -f $dir $dot
    done
}

# push files to github
GIT=`which git`
git(){
    ${GIT} add .
    ${GIT} commit -m "update"
    ${GIT} push
}

backup && git && echo "Backup completed!"
