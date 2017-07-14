function ls --description 'Use ls but filter out useless files' --wraps ls
    if test (uname) = "Darwin"
        set -l param -G
    else
        set -l param --color=auto
    end

		if isatty 1
			if test (uname) != "Darwin"
				set param $param --indicator-style=classify
			end
		end

		if not __has_option -a $argv; and test (uname) != "Darwin"
			set param $param -I "*.pyc"
		end

		command ls $param $argv 
end
