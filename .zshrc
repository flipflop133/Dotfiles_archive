# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# configure zsh histroy
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# configure zsh compinit
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Annexes
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# set default sudoeditor
export SUDO_EDITOR=/usr/bin/nvim
# set nvim as default
export EDITOR=nvim
# always clear screen after exit ls
export LESS=R

# powerlevel10k
zinit ice depth=1 atload"!source ~/.p10k.zsh" lucid nocd
zinit light romkatv/powerlevel10k

# o-my-zsh
# key-binding
# always load fzf-bindings after key-bindings
zinit ice \
	 atload"!source /usr/share/fzf/key-bindings.zsh \
	 !source /usr/share/fzf/completion.zsh"
zinit snippet OMZ::lib/key-bindings.zsh
# git
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
# archlinux yarem,yain...
zinit ice wait"1" lucid
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
# systemd
zinit ice wait"1" lucid
zinit snippet OMZ::plugins/systemd/systemd.plugin.zsh
# double esc
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

# fast-syntax-highlighting, autosuggestions and completions
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	blockf \
	    zsh-users/zsh-completions \
	atload"!_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions

# ls colors
zinit pack for ls_colors

# fzf-tab
zinit ice wait lucid
zinit load Aloxaf/fzf-tab

# completion zstyle
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format brief
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':completion:*files' ignored-patterns '*?.o'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

###########
# ALIASES #
###########
alias hu='sudo du -sh ~' # Home Usage
alias ud='sudo pacman -Syyu' # UpDate
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'
alias ht='htop'
alias ll='ls -lh'
alias vi='nvim'
alias rf='sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist &'
alias svi='sudoedit'
alias sudo='sudo -v; sudo '
alias pt='sudo powertop'
alias rr='ranger'
alias pacorph='sudo pacman -Rns $(pacman -Qtdq)'
alias cl='clear'
alias nf='clear; neofetch'
alias q='python ~/.config/pythons-scripts/daily_quote/daily_quote.py | lolcat -p 1.5 -a -d 3'
alias top='bpytop'
# make and cd
function take() {
  mkdir -p $@ && cd ${@:$#}
}

# copy contents of a file to clipboard
function xcp() {
  cat $1 |xclip -selection clipboard
}

# read markdown files
rmd () {
  pandoc $1 | lynx -stdin
}

# preserve history for new instance
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# fzf
export FZF_CTRL_T_COMMAND="fd --type f --follow"
export FZF_ALT_C_COMMAND="fd --type d --follow"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#4d4d4c,bg:-1,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:-1,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'

# P10K extra customizations
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=false
unset POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
