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
# arm32 toolchain
# export PATH="$HOME/arm-linux-gnueabi/bin:$PATH"
# clang toolchain
# export PATH="$HOME/proton_clang/bin:$PATH"
# always clear screen after exit ls
export LESS=R

# powerlevel10k
zinit ice depth=1 atload"!source ~/.p10k.zsh" lucid nocd
zinit light romkatv/powerlevel10k

# o-my-zsh
# key-binding
# always load fzf-bindings after key-bindings
zinit ice lucid \
	 atload"!source /usr/share/fzf/key-bindings.zsh \
	 !source /usr/share/fzf/completion.zsh"
#zinit snippet OMZ::lib/key-bindings.zsh
# git
zinit ice lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
# archlinux yarem,yain...
zinit ice wait"2" lucid
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
# systemd
zinit ice wait"2" lucid
zinit snippet OMZ::plugins/systemd/systemd.plugin.zsh
# colored man-pages
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
# double esc
zinit ice wait"3" lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

# fast-syntax and autosuggestions
zinit wait lucid for \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	blockf \
	    zsh-users/zsh-completions \
	atload"_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions

# completion color
#zinit wait"0c" lucid reset \
# 	atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
#            \${P}sed -i 's/38;5;253/38;5;81/'\
#            \${P}sed -i \
#            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
#            \${P}dircolors -b LS_COLORS > c.zsh" \
#            	atpull'%atclone' pick"c.zsh" nocompile'!' \
#	atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
#	    trapd00r/LS_COLORS

# completion zstyle
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*files' ignored-patterns '*?.o'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''

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
alias nf='neofetch'
alias q='python ~/.config/pythons-scripts/daily_quote.py | lolcat -p 1.5 -a -d 3'
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
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
