###########
# GENERAL #
###########
set fish_greeting
set -x EDITOR nvim
set -x VISUAL nvim
export MAKEFLAGS="-j$nproc"

##########
# COLORS #
##########
set -U fish_pager_color_description   '#0097a7'

###########
# ALIASES #
###########
# packages
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias pu='yay -Syu'
alias pr='yay -Rns'

# system
alias df='df -h'
alias du='du -h'
alias lsblk='lsblk -afm'
alias fdisk='fdisk -L'
alias ls='ls --color=never --group-directories-first'
alias grep='grep --color=auto'
alias cl='clear'

# other
alias n='nnn -e'
alias vi='nvim'
alias nf='clear; neofetch'
alias top='bpytop'
alias xrp='python ~/.config/crypto-script/crypto.py'
alias q='python ~/.config/scripts/python/daily_quote/daily_quote.py | lolcat -p 1.5 -a -d 3'

#######
# NNN #
#######
source $HOME/.config/nnn/config.nnn
