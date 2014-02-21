#####Aliases##########

## Programming Aliases (aliases which help development)
alias bind-gits='sudo bindfs ~/gits/ /mnt/unencrypted/'
# Some for Vagrant
alias vag-u='vagrant up'
alias vag-h='vagrant halt'
alias vag-s='vagrant ssh'
alias vag-p='vagrant provision'

## Display aliases list
#alias aliases='more ~/.bash_aliases'

# some more ls aliases
alias ls='ls -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size
alias la='ls -Al'        # show hidden files
alias lr='ls -lR'        # recursive ls
alias lt='ls -ltr'        # sort by date
alias lm='ls -al |more'        # pipe through 'more'
alias tree='tree -Cs'        # nice alternative to 'ls'
alias ll='ls -l'        # long listing
alias l='ls -hF --color'    # quick listing
alias lsize='ls --sort=size -lhr' # list by size
alias lsd='ls -l | grep "^d"'   #list only directories

## Some Drupal aliases
alias drush='sudo drush -r /var/www ' # I WILL NOT TYPE THIS PATH BULLSHIT EVERY TIME!!! ALSO GOTTA SUDO

## Moving around & all that jazz
alias back='cd $OLDPWD'	  # go back
alias ..="cd .."		  # go up
alias ...="cd ../.."	  # go up twice
alias ....="cd ../../.."  # go up thrice
alias .....="cd ../../../.."  # four times
alias ......="cd ../../../../.." # five times

## Dir shortcuts
alias home='cd ~/'		# go to home directory
alias documents='cd ~/Documents'	# go to documents dir
alias downloads='cd ~/Downloads'	# go to downloads dir
alias localhost='cd /var/www'		# go to localhost
alias jtrk='cd ~/workspace/JagTrack' # go to JagTrack Eclipse directory
alias wrks='cd ~/workspace/'		# go to Eclipse home directory
alias drp='cd /var/www'			# go to Drupal root director (/var/www)

## Shorten and organize
alias reload='source ~/.bashrc'		# reload the bash shell with new
							# source

## Sudo fixes
alias install='sudo apt-get install' # remove sudo
alias remove='sudo apt-get remove'   # remove sudo
alias apt-update='sudo apt-get update' #remove sudo

## Dev related
alias restart-apache='sudo /etc/init.d/apache2 restart' # restart apache
alias restart-nginx='sudo service nginx restart' # restart nginx

# search for a package
alias search="apt-cache search"

#Command substiution
alias ff='sudo find / -name'	# Find a file easily

# Help
alias aliases='cat ~/.aliases.help | more'
alias bash-help='cat ~/.bash.help | more'

# Fix terminal commands
alias xclip='xclip -selection C'
alias bc='bc -l'

