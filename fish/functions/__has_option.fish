function __has_option --description "Pass in a desired option and a list of arguments and
                         if the option is found 0 is returned, otherwise 1"
	set -l desired_option $argv[1]
	set --erase argv[1]

	if test (echo $desired_option | head -c2) = "--"
		set -g pattern "^"$desired_option'$'
	else
		if test (echo "$desired_option" | head -c1) = "-"
			set desired_option (echo "$desired_option" | cut -c2-)
		end

		set -g pattern "-"$desired_option
	end

	for i in $argv
		if test -n (echo $i | grep -G -e $pattern)
			return 0
		end
	end

	return 1
end

