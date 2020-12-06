###########
# GENERAL #
###########
set fish_greeting
set -U EDITOR nvim
###########
# ALIASES #
###########
alias n='nnn -e'
alias ud='sudo pacman -Syyu' # UpDate
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias vi='nvim'
alias cl='clear'
alias nf='clear; neofetch'
alias q='python ~/.config/pythons-scripts/daily_quote/daily_quote.py | lolcat -p 1.5 -a -d 3'
alias top='bpytop'
alias xrp='python ~/.config/crypto-script/crypto.py'
