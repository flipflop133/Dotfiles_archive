#!/bin/bash
###################################################################################################################
#                                                                                                                 #
#  _____   ____ _______ ______ _____ _      ______  _____   __  __          _   _          _____ ______ _____     #
# |  __ \ / __ \__   __|  ____|_   _| |    |  ____|/ ____| |  \/  |   /\   | \ | |   /\   / ____|  ____|  __ \    #
# | |  | | |  | | | |  | |__    | | | |    | |__  | (___   | \  / |  /  \  |  \| |  /  \ | |  __| |__  | |__) |   #
# | |  | | |  | | | |  |  __|   | | | |    |  __|  \___ \  | |\/| | / /\ \ | . ` | / /\ \| | |_ |  __| |  _  /    #
# | |__| | |__| | | |  | |     _| |_| |____| |____ ____) | | |  | |/ ____ \| |\  |/ ____ \ |__| | |____| | \ \    #
# |_____/ \____/  |_|  |_|    |_____|______|______|_____/  |_|  |_/_/    \_\_| \_/_/    \_\_____|______|_|  \_\   #
#                                                                                                                 #
###################################################################################################################

# Save default IFS value
DefaultIFS=$IFS
dot=$(pwd)

# Backup utility
backup_utility(){
    # Display title
    clear
    echo -e "\e[96mDOTFILES BACKUP SCRIPT\e[0m"
    echo ''
    # define backup directory
    echo -e "\e[96mBackup directory:\e[0m"
    echo "$dot"

    # backup files
    backup(){
        # dot files directories
        directories=()
        input="dotfiles_list.txt"
        while IFS= read -r line
        do
            IFS=''
            directories+=($line)
            IFS=$DefaultIFS
        done < "$input"

        # Set IFS to '' so spaces are not ignored
        IFS=''
        # copy dotfiles to backup directory
        echo -e "\e[96mBackuping the following dotfiles:\e[0m"
        # backup new dotfiles
        for dir in ${directories[@]}; do
            # copy the dotfile
            echo "$dir"
            cp --parents -r -f "$HOME/$dir" $dot
            cp -r -f $dot$HOME/. $dot
            dir_rm=$dot/$HOME/
            parentdir="$(dirname "$dir_rm")"
            rm -rf $parentdir
        done
        echo -e "\e[96mDotfiles backup done!\e[0m"
        # Reset IFS to its default value
        IFS=$DefaultIFS
        echo ''
    }

    # backup list of installed packages
    backup_app(){
        read -r -p "Backup explicitly installed app list? [y/N]" response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            pacman -Qe |awk '{print $1}'> appList.txt && echo -e "\e[96mApp list backup done!\e[0m"
        else
            echo -e "\e[96mSkipping app list backup.\e[0m"
        fi
        echo ''
    }

    backup_system(){
        # backup system files
        read -r -p "Backup system files? [y/N]" response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            # get system files directories
            system_directories=()
            input="system_files.txt"
            while IFS= read -r line
            do
                IFS=''
                system_directories+=($line)
                IFS=$DefaultIFS
            done < "$input"

            # Set IFS to '' so spaces are not ignored
            IFS=''
            # create .root directory if it doesn't exist
            if [ ! -d ".root" ]
            then
                mkdir -p ".root"
            fi
            # copy system file to backup directory
            echo -e "\e[96mBackuping the following system files:\e[0m"
            for dir in ${system_directories[@]}; do
                # copy the system file
                echo "$dir"
                cp --parents -r -f "$dir" $dot/.root/
            done
            echo -e "\e[96mSystem files backup done!\e[0m"
            # Reset IFS to its default value
            IFS=$DefaultIFS
            echo ''
        else
            echo -e "\e[96mSkipping system files backup.\e[0m"
        fi
        echo ''
    }

    # push files to the user repo
    user_repo=$(git config --get remote.origin.url)
    git(){
        GIT=`which git`
        echo -e "\e[96mDo you want to push the backup to the following repo?\e[0m"
        echo "$user_repo"
        read -r -p "[y/N]" response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            echo -e "\e[96mPushing files to your repo.\e[0m"
            ${GIT} add .
            ${GIT} reset dotfiles_manager.sh
            read -r -p "Commit message:" response
            ${GIT} commit -m "$response"
            ${GIT} push
        fi
        echo ''
    }

    # execute the functions
    backup
    backup_app
    backup_system
    git
    echo -e "\e[96mBackup completed!\e[0m"
}

# Restore utility
restore_utility(){
    clear

    # restore files
    restore(){
        # dot files directories
        directories=()
        input="dotfiles_list.txt"
        while IFS= read -r line
        do
            IFS=''
            directories+=($line)
            IFS=$DefaultIFS
        done < "$input"

        # Set IFS to '' so spaces are not ignored
        IFS=''
        # copy dotfiles to their directories
        echo -e "\e[96mRestoring the following dotfiles:\e[0m"
        # restore dotfiles
        for dir in ${directories[@]}; do
            # copy the dotfile
            echo "$dot/$dir $HOME/$dir"
            if [ -d "$dot/$dir/." ]; then
                cp -r -f "$dot/$dir/." "$HOME/$dir"
            else
                cp -r -f "$dot/$dir" "$HOME/$dir"
            fi

        done
        echo -e "\e[96mDotfiles restore done!\e[0m"
        # Reset IFS to its default value
        IFS=$DefaultIFS
        echo ''
    }

    restore_system(){
        # restore system files
        read -r -p "Restore system files? [y/N]" response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            # get system files directories
            system_directories=()
            input="system_files.txt"
            while IFS= read -r line
            do
                IFS=''
                system_directories+=($line)
                IFS=$DefaultIFS
            done < "$input"
            if [ $(id -u) -eq 0 ]
            then
                # Set IFS to '' so spaces are not ignored
                IFS=''
                # copy system files to their directories
                echo -e "\e[96mRestoring the following system files:\e[0m"
                for dir in ${system_directories[@]}; do
                    echo "$dir"
                    if [ -d "$dot/.root$dir/." ]; then
                        # copy directory
                        cp -r -f "$dot/.root$dir/." "$dir"
                    else
                        #copy file
                        cp -r -f "$dot/.root$dir" "$dir"
                    fi
                done
                echo -e "\e[96mSystem files restore done!\e[0m"
                # Reset IFS to its default value
                IFS=$DefaultIFS
                echo ''
            else
                echo -e "\e[31mPlease run script as root.\e[0m"
                exit
            fi
        else
            echo -e "\e[96mSkipping system files restore.\e[0m"
        fi
        echo ''
    }

    # execute the functions
    echo -e "\e[96m1)Restore dotfiles\e[0m"
    echo -e "\e[96m2)Restore system files\e[0m"
    read -r -p "Enter a selection:" response
    if [ "$response" == "1" ]; then
        restore
    elif [ "$response" == "2" ]; then
        restore_system
    else
        clear
        echo -e "\e[31mPlease enter a valid value\e[0m"
        backup
    fi
}

# MAIN
main(){
    echo -e "\e[96mDOTFILES MANAGER SCRIPT\e[0m"
    echo ''
    echo -e "\e[96m1)Backup utility\e[0m"
    echo -e "\e[96m2)Restore utility\e[0m"
    read -r -p "Enter a selection:" response
    if [ "$response" == "1" ]; then
        backup_utility
    elif [ "$response" == "2" ]; then
        restore_utility
    else
        clear
        echo -e "\e[31mPlease enter a valid value\e[0m"
        main
    fi
}
clear
main
