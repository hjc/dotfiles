function ls --description 'Use ls but filter out useless files' --wraps ls
    set -l param --color=auto

		if isatty 1
			set param $param --indicator-style=classify
		end

		if not __has_option -a $argv
			set param $param -I "*.pyc"
		end

		command ls $param $argv 
end
