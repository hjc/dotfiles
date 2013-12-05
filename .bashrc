# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes
    BLACK='\e[0;30m'
    BLUE='\e[0;34m'
    GREEN='\e[0;32m'
    CYAN='\e[0;36m'
    RED='\e[0;31m'
    PURPLE='\e[0;35m'
    BROWN='\e[0;33m'
    LIGHTGRAY='\e[0;37m'
    DARKGRAY='\e[1;30m'
    LIGHTBLUE='\e[1;34m'
    LIGHTGREEN='\e[1;32m'
    LIGHTCYAN='\e[1;36m'
    LIGHTRED='\e[1;31m'
    LIGHTPURPLE='\e[1;35m'
    YELLOW='\e[1;33m'
    WHITE='\e[1;37m'
    NC='\e[0m'
    ;;
esac

export EDITOR="vim"

if [ -f ~/.bash_gh ]; then
	. ~/.bash_gh
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.bashgit ]; then
	. ~/.bashgit
fi

if [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash
fi

# Easy extract
extract() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)	tar xvjf $1 	;;
			*.tar.gz)	tar xvzf $1	;;
			*.bz2)		bunzip2  $1 	;;
			*.rar)		rar x    $1 	;;
			*.gz)		gunzip   $1 	;;
			*.tar)		tar xvf  $1 	;;
			*.tbz2)		tar xvjf $1 	;;
			*.tgz)		tar xvzf $1 	;;
			*.zip)		unzip    $1 	;;
			*.Z)		uncompress $1 	;;
			*.7z)		7z x     $1 	;;
			*)		echo "Don't know how to extract '$1'..." ;;
		esac

	else
		echo "'$1' is not a valid file!"
	fi
}

vagrant-up () {
	CWD=$(pwd);
	cd /mnt/unencrypted/$1;
	vagrant up;
	cd $CWD;
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias 'ssh-aliases'='cat ~/.ssh/config | grep Host'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi




#old with date
#export PS1='\[\e[1;35m\]\D{%I:%M:%S %P (%a %b %d, %y)}\[\e[00m\]\n\n\[\e[1;36m\]\u\[\e[00m\][\[\e[01;34m\]\h\[\e[00m]\] \[\e[0;32m\]{\[\e[1;32m\]\w\[\e[0;32m\]}\[\e[0;33m\]$(__git_ps1) \[\e[0;31m\]~>\[\e[00m\] '

export PS1='\[\e[1;36m\]\u\[\e[00m\][\[\e[01;34m\]\h\[\e[00m]\] \[\e[0;32m\]{\[\e[1;32m\]\w\[\e[0;32m\]}\[\e[0;33m\]$(__git_ps1) \[\e[0;31m\]~>\[\e[00m\] '

#export PS1='\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]'

#cupcakepounder69

# Check this shit out, some good stuff in here
#
# if [ -f /etc/bash_completion ]; then
#     source /etc/bash_completion
# fi

# __has_parent_dir () {
#     # Utility function so we can test for things like .git/.hg without firing
#     # up a separate process
#     test -d "$1" && return 0;

#     current="."
#     while [ ! "$current" -ef "$current/.." ]; do
#         if [ -d "$current/$1" ]; then
#             return 0;
#         fi
#         current="$current/..";
#     done

#     return 1;
# }

# __vcs_name() {
#     if [ -d .svn ]; then
#         echo "-[svn]";
#     elif __has_parent_dir ".git"; then
#         echo "-[$(__git_ps1 'git %s')]";
#     elif __has_parent_dir ".hg"; then
#         echo "-[hg $(hg branch)]"
#     fi
# }

# black=$(tput -Txterm setaf 0)
# red=$(tput -Txterm setaf 1)
# green=$(tput -Txterm setaf 2)
# yellow=$(tput -Txterm setaf 3)
# dk_blue=$(tput -Txterm setaf 4)
# pink=$(tput -Txterm setaf 5)
# lt_blue=$(tput -Txterm setaf 6)

# bold=$(tput -Txterm bold)
# reset=$(tput -Txterm sgr0)

# export PS1='\n\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-[\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\w\[$black\]]\[\033[0;33m\]$(__vcs_name) \[\033[00m\]\[$reset\]\n\[$reset\]\$ '

# alias ls='ls -F --color=always'
# alias dir='dir -F --color=always'
# alias ll='ls -l'
# alias cp='cp -iv'
# alias rm='rm -i'
# alias mv='mv -iv'
# alias grep='grep --color=auto -in'
# alias v='vim'
# alias ..='cd ..'
