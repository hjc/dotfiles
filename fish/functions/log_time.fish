function log_time
	set args (getopt -s sh t $argv)
	set args (fish -c "for el in $args; echo \$el; end")
	set i 1
	while true
		switch $args[$i]
			case "-t"
				set test -t
			case "--"
				break
		end
		set i (math "$i + 1")
	end
	gpg --decrypt ~/.crypt/locker/mc3_prod_cookie.txt.asc > cookie ; \
      and env USER_COOKIE=(cat cookie) DEFAULT_USER_ID=13 \
      python ~/Dropbox/Programming/play.py \
      -f ~/Dropbox/Programming/hours.yaml \
      -p ~/Dropbox/Programming/projects.yaml \
      $test;
  rm cookie;
end
