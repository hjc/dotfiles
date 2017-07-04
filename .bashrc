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

# Combine history from multiple terminals into one file instead of permanently
# losing it
export PROMPT_COMMAND="history -a; history -n"

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

if [ -f $(pwd)/.bash_gh ]; then
	. $(pwd)/.bash_gh
fi

if [ -f $(pwd)/.bash_aliases ]; then
	. $(pwd)/.bash_aliases
fi

if [ -f $(pwd)/.bashgit ]; then
	. $(pwd)/.bashgit
fi

if [ -f $(pwd)/.git-completion.bash ]; then
	source $(pwd)/.git-completion.bash
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

# vagrant helpers for encrypted home directores and bindfs
vagrant-up () {
	CWD=$(pwd);
	TAR_DIR=$1;
	if [ -z ${TAR_DIR} ]; then
		arr=$(echo $CWD | tr "/" "\n");
		for x in ${arr}
		do
			val=${x};
		done
		TAR_DIR=${val};
	fi 
	cd /mnt/unencrypted/$TAR_DIR;
        if [[ $? != 0 ]]; then
            # we haven't done bindfs yet, set us up
            bind-gits
        fi
	vagrant up;
	cd ${CWD};
}

vagrant-halt () {
	CWD=$(pwd);
	cd /mnt/unencrypted/$1;
	vagrant halt;
	cd ${CWD};
}

vagrant-ssh () {
        CWD=$(pwd);
        cd /mnt/unencrypted/$1;
        vagrant ssh;
        cd ${CWD};
}

vagrant-provision () {
	    CWD=$(pwd);
        cd /mnt/unencrypted/$1;
        vagrant provision;
        cd ${CWD};
}

vpn () {
    sudo openvpn ~/.config/openvpn/$1.client.ovpn
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi
#
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias 'ssh-aliases'='cat ~/.ssh/config | grep Host'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $(pwd)/.bash_aliases ]; then
    . $(pwd)/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f $(pwd)/.bash_includes ]; then
    . $(pwd)/.bash_includes
fi


export PS1='\[\e[1;36m\]\u\[\e[00m\][\[\e[01;34m\]\h\[\e[00m\]] \[\e[0;32m\]{\[\e[1;32m\]\w\[\e[0;32m\]}\[\e[0;33m\]$(__git_ps1) \[\e[0;31m\]~>\[\e[00m\] '

# use xdotool to slightly move the mouse in order to disable a screensaver. Was used for
# a Raspberry Pi project when all normal screensaver disabling techniques failed.
no-screensaver () {
	COUNTER=0;
	while [ $COUNTER -ne "-1" ]; do
		xdotool mousemove $COUNTER 0
		COUNTER=$(echo "$COUNTER + 5" | bc)
		if [ $COUNTER -eq "255" ]; then
			COUNTER=0
		fi
		sleep 7m;
	done
}

# sleep a given number of seconds and then alert a message
delayed-alert () {
	(sleep $1 && notify-send -u critical -t 0 "$2") &
}

# echo out the unicode for the disapproval look
disapproval-look () {
	echo "ಠ_ಠ"
}

gifs () {
  if [ $1 == "barney-confetti" ]; then
    printf "http://whateverblog.dallasnews.com/files/2013/06/barney-confetti.gif";
  elif [ $1 == "rock-clapping" ]; then
    printf "http://i.imgur.com/dhMeAzK.gif"
  elif [ $1 == "excited-tswift" ]; then
    printf "http://i.giphy.com/u23zXEvNsIbfO.gif"
  elif [ $1 == "disgusted-tswift" ]; then
    printf "http://i.giphy.com/c5z3EDtBsgLwA.gif"
  elif [ $1 == "mind-blown" ]; then
    printf "http://www.reactiongifs.com/r/2011/09/mind_blown.gif"
  elif [ $1 == "thumb" ]; then
    printf "https://thechive.files.wordpress.com/2014/03/chuck-norris-thumbs-up-dodgeball-gif.gif"
  elif [ $1 == "thumbs-up" ]; then
    printf "https://thechive.files.wordpress.com/2014/03/chuck-norris-thumbs-up-dodgeball-gif.gif"
  elif [ $1 == "cram-it" ]; then
    printf "http://f.cl.ly/items/0w1j3w2k2b383T3c1M3k/cramit.png"
  elif [ $1 == "shrug" ]; then
    printf "¯\_(ツ)_/¯"
  elif [ $1 == "confused-tswift" ]; then
    printf "http://i.giphy.com/uLTvMTebsVdSw.gif"
  elif [ $1 == "disappointed-tswift" ]; then
    printf "http://i.giphy.com/w3j54RqQkzY9W.gif"
  elif [ $1 == "acceptance-shrug-tswift" ]; then
    printf "http://i.giphy.com/1DfdCZ4X6eDCw.gif"
  elif [ $1 == "shrug-tswift" ]; then
    printf "http://i.giphy.com/qsbpGsQJef8l2.gif"
  elif [ $1 == "heart-tswift" ]; then
    printf "http://i.giphy.com/fpakjlMN495vi.gif"
  elif [ $1 == "excited-charlie" ]; then
    printf "http://i.giphy.com/s1SqOgMcBm5Ak.gif"
  elif [ $1 == "contained-excited-charlie" ]; then
    printf "http://i.giphy.com/2JsswGOTfr3lC.gif"
  elif [ $1 == "ill-allow-it" ]; then
    printf "http://i.giphy.com/SmoCFhZCi1kzu.gif"
  elif [ $1 == "checkmark" ]; then
    printf "✔"
  elif [ $1 == "table-flip" ]; then
    printf "(╯°□°)╯︵ ┻━┻"
  elif [ $1 == "excited-scream" ]; then
    printf "http://i.giphy.com/2alKkyRFPKRSU.gif"
  elif [ $1 == "excited-andy" ]; then
    printf "http://i.giphy.com/90F8aUepslB84.gif"
  elif [ $1 == "single-tear-of-joy" ]; then
    printf "http://boards.fightingamphibians.org/ani/src/131051195738.jpg"
  elif [ $1 == "tears-of-joy" ]; then
    printf "http://3.bp.blogspot.com/-w_PnKVAXhHI/UDyxgexYO0I/AAAAAAAAALE/bIh_XzNZrx8/s320/tears+of+joy.gif"
  elif [ $1 == "nicolas-cage-universe" ]; then
    printf "http://i.imgur.com/d3XtuP3.gif"
  elif [ $1 == "its-happening" ]; then
    printf "http://i.giphy.com/rl0FOxdz7CcxO.gif"
  elif [ $1 == "hot-damn" ]; then
    printf "http://i.giphy.com/80KYXCRVLo1ji.gif"
  elif [ $1 == "nailed-it" ]; then
    printf "http://i.giphy.com/8VrtCswiLDNnO.gif"
  elif [ $1 == "oh-stop-it-you" ]; then
    printf "http://img1.wikia.nocookie.net/__cb20140909101218/thehungergames/images/e/ea/Oh_stop_it_you.png"
  elif [ $1 == "charlie-brown-walk" ]; then
    printf "http://static.celebuzz.com/uploads/2013/05/22/ad-charliebrown.gif"
  elif [ $1 == "very-nice" ]; then
    printf "https://i.imgur.com/lqKlotB.png"
  elif [ $1 == "fma-tears-of-joy" ]; then
    printf "http://i.imgur.com/QEIl3Kq.gif"
  elif [ $1 == "i-have-no-idea-what-im-doing" ]; then
    printf "http://i.kinja-img.com/gawker-media/image/upload/japbcvpavbzau9dbuaxf.jpg"
  elif [ $1 == "mission-accomplished" ]; then
    printf "http://i.imgur.com/mlTtOgB.jpg"
  elif [ $1 == "computer-kid" ]; then
    printf "http://i1.kym-cdn.com/photos/images/original/000/538/716/7f5.gif"
  elif [ $1 == "you-beautiful-bastard" ]; then
    printf "https://camo.githubusercontent.com/3b4af199653fad2e4be3af9c972bff325a552791/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f7663676f6e47706c4e474d56692f67697068792e676966"
  elif [ $1 == "you-da-man" ]; then
    printf "http://i.giphy.com/lsr3605ZkSCpG.gif"
  elif [ $1 == "you-got-this" ]; then
    printf "http://i.giphy.com/4Vtk42BGiL1T2.gif"
  elif [ $1 == "i-love-you-man" ]; then
    printf "http://i.giphy.com/R2HXwaQ26bCHS.gif"
  elif [ $1 == "group-hug" ]; then
    printf "https://isisthescientist.files.wordpress.com/2014/06/group-hug.gif?w=500&h=242"
  elif [ $1 == "how-many-fucks-i-give" ]; then
    printf "http://nofuckstogive.today/images/fucks/colbert.gif"
  elif [ $1 == "troll-toll" ]; then
    printf "https://pbs.twimg.com/media/B-GDPTaCAAA57cd.jpg"
  elif [ $1 == "pure-sadness" ]; then
    printf "http://i.giphy.com/jou4Cd2mx1lGU.gif"
  elif [ $1 == "group-hug" ]; then
    printf "http://i.giphy.com/TMMpsJi3KVKU0.gif"
  elif [ $1 == "i-love-you" ]; then
    printf "http://i.giphy.com/X3FmqQ7ehoCBy.gif"
  elif [ $1 == "safe" ]; then
    printf "http://1.bp.blogspot.com/-F-mGs8sP7xU/UWhns5TZuLI/AAAAAAAACnk/RhGfGNZA-7o/s1600/pete-rose-001295159.jpg"
  elif [ $1 == "end-of-story" ]; then 
    printf "http://i.memeful.com/memes/MAE4avM.jpg"
  elif [ $1 == "disapproval-daniel" ]; then
    printf "http://i.imgur.com/FdohIci.jpg"
  elif [ $1 == "jetpak" ]; then
    printf "http://i.imgur.com/oSL38pv.png"
  elif [ $1 == "colinstachio" ]; then
    printf "http://i.imgur.com/ZSa0rAn.jpg"
  elif [ $1 == "smile-nod" ]; then
    printf "http://i.giphy.com/CE5MnZFgbVZmg.gif"
  elif [ $1 == "fuck-your-sandwich" ]; then
    printf "https://media.giphy.com/media/14iaJZ6endy32o/giphy.gif"
  elif [ $1 == "relieved-carlton" ]; then
    printf "https://media.giphy.com/media/P8MxmGnjmytws/giphy.gif"
  elif [ $1 == "drug-party" ]; then
    printf "https://media.giphy.com/media/lHhrUlDykov4c/giphy.gif"
  elif [ $1 == "wayne-ok-then" ]; then
    printf "http://i.giphy.com/Hf61JhIufsQTe.gif"
  elif [ $1 == "confused-nod" ]; then
    printf "http://i.giphy.com/XCGcCXXJaF5Ru.gif"
  elif [ $1 == "creepy-ok" ]; then
    printf "http://i.giphy.com/Y01jP8QeLOox2.gif"
  elif [ $1 == "alrighty-then" ]; then
    printf "http://i.giphy.com/5hc2bkC60heU.gif"
  elif [ $1 == "kissy-face" ]; then
    printf "http://i.giphy.com/mNRu0pk6WLiZa.gif"
  elif [ $1 == "are-we-having-fun-yet" ]; then
    printf "https://media.giphy.com/media/l41lNRz0uXPQLm0RG/giphy.gif"
  elif [ $1 == "this-is-internet" ]; then
    printf "http://cdn1.tnwcdn.com/wp-content/blogs.dir/1/files/2015/02/ctXFWZl-1.gif"
  elif [ $1 == "slow-drink-sip" ]; then
    printf "https://media.giphy.com/media/gsaWHQ4mn6o4E/giphy.gif"
  elif [ $1 == "not-the-tech-debt-youre-looking-for" ]; then
    printf "https://i.imgflip.com/uoovy.jpg"
  elif [ $1 == "obama-thumbs" ]; then
    printf "http://www.allthingsxbox.com/wp-content/uploads/2014/06/Obama-Thumbs-Up.jpg"
  elif [ $1 == "hank-suicide" ]; then
    printf "http://images.rapgenius.com/e4bf8e14727d7bef4e4e1ffe9c8bff64.500x384x14.gif"
  elif [ $1 == "slow-laugh" ]; then
    printf "http://i.imgur.com/RIycws4.gif"
  elif [ $1 == "problem-solver" ]; then
    printf "http://zidtees.com/products/square/86113.png"
  elif [ $1 == "plan-comes-together" ]; then
    printf "http://clipperdata.com/wp-content/uploads/2015/07/I-love-it-when-a-plan-comes-together.jpg"
  elif [ $1 == "im-dead-inside" ]; then
    printf "http://www.crushable.com/wp-content/uploads/2014/01/Steve-Carell-as-Michael-Scott-from-The-Office-I-am-dead-inside-GIF.gif"
  elif [ $1 == "fix-it" ]; then
    printf "http://i.giphy.com/l41lPzvoHCKXBpK2A.gif"
  elif [ $1 == "you-got-it-dude" ]; then
    printf "https://media.giphy.com/media/l41lZxzroU33typuU/giphy.gif"
  elif [ $1 == "ad-mission-accomplished" ]; then
    printf "http://vignette2.wikia.nocookie.net/arresteddevelopment/images/2/27/2x02_The_One_Where_They_Build_a_House_%28107%29.png"
  elif [ $1 == "addicted" ]; then
    printf "https://media.giphy.com/media/ABwu13jkMNBG8/giphy.gif"
  elif [ $1 == "i-dont-give-a-fuck" ]; then
    printf "http://markmanson.net/wp-content/uploads/2015/01/tim_optimized.png"
  elif [ $1 == "deal-with-it" ]; then
    printf "https://media.giphy.com/media/fWQ8jd99TJR6g/giphy.gif"
  elif [ $1 == "lem-deal-with-it" ]; then
    printf "https://31.media.tumblr.com/tumblr_lmm3eeLL6g1qfkkd8.gif"
  elif [ $1 == "hello-there" ]; then
    printf "https://media.giphy.com/media/3ornk57KwDXf81rjWM/giphy.gif"
  elif [ $1 == "totally-rad" ]; then
    printf "http://i.giphy.com/qaK268nieNELC.gif"
  elif [ $1 == "youre-welcome" ]; then
    printf "http://i.giphy.com/ZOysprYCwzuVi.gif"
  elif [ $1 == "delivery" ]; then
    printf "https://media.giphy.com/media/lcv7NCKzJJ2XC/giphy.gif"
  elif [ $1 == "cream-rises-to-the-top" ]; then
    printf "https://i.imgur.com/57iRLbn.gif"
  elif [ $1 == "white-hot-cream" ]; then
    printf "http://25.media.tumblr.com/68c1abaf2c8b66488327b7de30080ace/tumblr_mw4r3h1ayu1qa71fyo2_250.gif"
  elif [ $1 == "how-many-fucks-i-give" ]; then
    printf "https://media.giphy.com/media/8OgYgkuzrfA0o/giphy.gif"
  elif [ $1 == "boom" ]; then
    printf "http://i.giphy.com/NmrqUdwGXPOog.gif"
  elif [ $1 == "hell-yea" ]; then
    printf "https://camo.githubusercontent.com/8014b745a5fa25922963301b0d8811f4b7852bbf/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f785469546e45716d4f46586d6c5a565462692f67697068792e676966"
  elif [ $1 == "snap-out-of-it" ]; then
    printf "http://i.giphy.com/slbQo8QFOUi1W.gif"
  elif [ $1 == "so-happy-i-could-dance" ]; then
    printf "http://i.giphy.com/jd6TVgsph6w7e.gif"
  elif [ $1 == "dance-squad" ]; then 
    printf "https://media.giphy.com/media/10IvkVuIKqMTrW/giphy.gif"
  elif [ $1 == "meh" ]; then
    printf "http://i.giphy.com/3ornjSL2sBcPflIDiU.gif"
  elif [ $1 == "have-fun" ]; then
    printf "https://media.giphy.com/media/hOFcww5Q7nVzG/giphy.gif"
  elif [ $1 == "bb8-thumbs-up" ]; then
    printf "https://media.giphy.com/media/3o7abB06u9bNzA8lu8/giphy.gif"
  elif [ $1 == "i-am-the-senate" ]; then
    printf "https://media.giphy.com/media/kJWYrH269RK8M/giphy.gif"
  elif [ $1 == "cram-it" ]; then
    printf "http://happybunny.orbitearthstores.com/images/hicramitsticker-huge.jpg"
  elif [ $1 == "chosen-one" ]; then
    printf "https://camo.githubusercontent.com/b86149f2195b982f54a3af2052ac99a3fbd23f8d/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f336f726e6a4a5371327339787a6e684f38302f67697068792e676966"
  elif [ $1 == "come-to-the-dark-side" ]; then
    printf "http://www.troll.me/images/grinning-emperor-palpatine/yes-yes-come-to-the-dark-side.jpg"
  elif [ $1 == "when-you-do-things-right" ]; then
    printf "https://s-media-cache-ak0.pinimg.com/736x/35/58/73/3558731bdd312d132459c63b4752e0dd.jpg"
  elif [ $1 == "suck-it" ]; then
    printf "https://s-media-cache-ak0.pinimg.com/736x/f0/18/c1/f018c134f88a13b5ff0f700a5c59c1db.jpg"
  elif [ $1 == "feels-good-man" ]; then
    printf "http://ct.iscute.com/ol/ic/sw/i60/2/1/20/ic_c3a373dfaf22553996440877083574d5.jpg"
  elif [ $1 == "no-woman-no-cry" ]; then
    printf "http://d22zlbw5ff7yk5.cloudfront.net/images/stash-1-50b66dd716d05.gif"
  elif [ $1 == "man-hug" ]; then
    printf "http://static.stereogum.com/uploads/2013/05/zachwoody5.gif"
  elif [ $1 == "dodging" ]; then
    printf "https://media.giphy.com/media/QA88yMhazfDI4/giphy.gif"
  elif [ $1 == "alright" -o $1 == "alright-alright" -o $1 == "alright-alright-alright" ]; then
    printf "http://i.giphy.com/lgRNj0m1oORfW.gif"
  elif [ $1 == "whaaattt-applause" ]; then
    printf "https://stickers.acidodivertido.com/wp-content/uploads/2016/01/Whaaat-Telegram-Animated-Gifs-gifs.acidodivertido.com_.gif"
  elif [ $1 == "oh-come-on" ]; then
    printf "https://media.giphy.com/media/MRLc0oJPeTcIw/giphy.gif"
  elif [ $1 == "help-me-help-you" ]; then
    printf "https://lh3.googleusercontent.com/-OPtIepRHfk0/Vw6D5HkxHEI/AAAAAAAAFhY/j5zWe3mt1NQ-92OPME0XMhKavCSApq_Ow/w1087-h625/help-me-help-you.gif"
  elif [ $1 == "middle-finger" ]; then
    printf "http://i.giphy.com/10XWz7NQ3xvq9O.gif"
  elif [ $1 == "middle-finger-small" ]; then
    printf "http://i.giphy.com/JNz19eZvQsv3a.gif"
  elif [ $1 == "preach" ]; then
    printf "https://media.giphy.com/media/vYGsUUBVbWVBC/giphy.gif"
  elif [ $1 == "oh-you" ]; then
    printf "http://i.giphy.com/fJPsqicaMZaZW.gif"
  elif [ $1 == "pleased-finally" -o $1 == "starlord-finally" ]; then
    printf "https://media.giphy.com/media/CkqpoOOS0BCQU/giphy.gif"
  elif [ $1 == "head-shake-acceptance" ]; then
    printf "https://fictionismagic.files.wordpress.com/2014/06/head-shake-gif.gif"
  elif [ $1 == "cried-this-morning" ]; then
    printf "http://i.giphy.com/afKtt0qqDvwIw.gif"
  elif [ $1 == "yea-baby-i-know-it" ]; then
    printf "https://cdn.meme.am/instances/28014723.jpg"
  elif [ $1 == "fistbump" ]; then
    printf "https://media.giphy.com/media/wc2O4hShZnO9i/giphy.gif"
  elif [ $1 == "feels-goodman" ]; then
    printf "http://i2.kym-cdn.com/photos/images/facebook/000/021/073/1254172884282.jpg"
  elif [ $1 == "fucking-way-she-goes" ]; then
    printf "https://pbs.twimg.com/media/BFYGmNICUAA5z0A.jpg"
  elif [ $1 == "now-kiss" -o $1 == "now-kith" ]; then
    printf "https://i.imgur.com/hUNAo.jpg"
  elif [ $1 == "that-would-be-great" ]; then
    printf "https://media.giphy.com/media/gsaWHQ4mn6o4E/giphy.gif"
  elif [ $1 == "face-palm" ]; then
    printf "http://media1.giphy.com/media/6OWIl75ibpuFO/giphy.gif"
  elif [ $1 == "gods-vagina" ]; then
    printf "http://25.media.tumblr.com/cd6a8cfb8c361d79febcfe1d858cebef/tumblr_myrh18d2HQ1rznvc3o1_500.gif"
  elif [ $1 == "jump" -o $1 == "jumping" ]; then
    printf "https://media.giphy.com/media/BKlTlVCkeSyZ2/giphy.gif"
  elif [ $1 == "oh-snap" ]; then
    printf "https://media.giphy.com/media/13ywUiX9SwSlGM/giphy.gif"
  elif [ $1 == "mongo-pawn" ]; then
    printf "https://media.giphy.com/media/sDASzmsIZ5se4/giphy.gif"
  elif [ $1 == "anything-goes" ]; then
    printf "https://media.giphy.com/media/26BRBFvwOWOzPwZA4/giphy.gif"
  elif [ $1 == "success-kid" ]; then
    printf "https://upload.wikimedia.org/wikipedia/en/f/ff/SuccessKid.jpg"
  elif [ $1 == "dont-have-all-day" ]; then
    printf "http://i.imgur.com/t4VvESR.gif"
  elif [ $1 == "atodaso" ]; then
    printf "http://www.quickmeme.com/img/56/5691a5e1d316da2178fbef2ca412f23e2a9d3ea0544f58abfe74432793c8cd64.jpg"
  elif [ $1 == "hancock-good-job" ]; then
    printf "http://img.pandawhale.com/post-36867-good-job-gif-Hancock-Will-Smit-8fLm.gif"
  elif [ $1 == "whateva-i-do-what-i-want" ]; then
    printf "https://media.giphy.com/media/hdN8FFzN0UEoM/giphy.gif"
  elif [ $1 == "i-did-a-bad-thing" -o $1 == "not-like-this" ]; then
    printf "https://i.imgur.com/FfY35iw.gif"
  elif [ $1 == "haha-beautiful" ]; then
    printf "http://vignette1.wikia.nocookie.net/glee/images/6/61/Hahaha-beautiful-o.gif"
  elif [ $1 == "not-like-zis" ]; then
    printf "http://iruntheinternet.com/lulzdump/images/gifs/matrix-reaction-not-like-this-switch-unplugged-1385293342s.gif"
  elif [ $1 == "know-some-words" ]; then
    printf "http://i.giphy.com/zXA5VEmXr7OUg.gif"
  elif [ $1 == "what-is-this-middle-finger" ]; then
    printf "https://media.giphy.com/media/XHr6LfW6SmFa0/giphy.gif"
  elif [ $1 == "best-buds" ]; then
    printf "http://i.giphy.com/3o7qDUwMMQn5FjOo5G.gif"
  elif [ $1 == "this-is-bullshit" ]; then
    printf "http://i.giphy.com/2Gf91Ug720sCs.gif"
  elif [ $1 == "youre-doing-it-peter" ];then
    printf "http://i.giphy.com/8hxcSjDr51mes.gif"
  elif [ $1 == "in-neil-we-trust" ]; then
    printf "https://c2.staticflickr.com/8/7104/13939084195_94902254fe_b.jpg"
  elif [ $1 == "gentleman" ]; then
    printf "http://i.imgur.com/DH3j4er.gif"
  elif [ $1 == "abort" ]; then
    printf "http://i.giphy.com/3osxY9xCBxlndni2XK.gif"
  elif [ $1 == "fuck-yea" ]; then
    printf "http://i.giphy.com/XrULfYdI26uIM.gif"
  elif [ $1 == "always-watching" ]; then
    printf "https://s-media-cache-ak0.pinimg.com/564x/fe/82/ea/fe82eac7766eff1bdf64b11c5d27e293.jpg"
  elif [ $1 == "i-got-that-reference" -o $1 == "i-understood-that-reference" ]; then
    printf "http://i.imgur.com/XS5LK.gif"
  elif [ $1 == "fucking-woo" ]; then
    printf "http://24.media.tumblr.com/tumblr_m9e4dazjxY1qm64qlo1_500.gif"
  fi
}

function pull-new-salt-project() {
  if [ -z "$1" ]; then
    echo "No project given!"
    return 1
  fi

  ssh croscon.salt "cd /devops/projects/$1 && sudo git pull"

}

function pull-salt-project() {
  if [ -z "$1" ]; then
    echo "No project given!"
    return 1
  fi

  ssh croscon.devops "cd /devops/projects/$1 && sudo git pull"

}

function runningvms() {
  vboxmanage list runningvms
}

function pass() {
  LENGTH="32";
  if [ -n "$1" ]; then
    LENGTH="$1";
  fi
  POS=$((${LENGTH} + 1))
  dd if=/dev/urandom bs=64 count=1 2>/dev/null | base64 | tr -d '\n' | rev | cut -c3-${POS};
}

function urlsafe-pass() {
  pass | tr -d -c '[:alnum:]\n'
}

#export PS1='\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]'

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

# The next line updates PATH for the Google Cloud SDK.
source '/home/hayden/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/home/hayden/google-cloud-sdk/completion.bash.inc'

export PATH="$PATH:~/.gstorage/gsutil"
export PATH="$PATH:/opt/jq"
export PATH="$PATH:~/.keybase/bin"
eval $(thefuck --alias)
