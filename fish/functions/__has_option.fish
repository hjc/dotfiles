function __has_option --description "Pass in a desired option and a list of arguments and
                         if the option is found 0 is returned, otherwise 1"
	set desired_option $argv[1]
	set --erase argv[1]

	if test (expr substr "$desired_option" 1 2) = "--"
		set -l pattern "^"$desired_option'$'
	else
		if test (expr substr "$desired_option" 1 1) = "-"
			set desired_option (expr substr "$desired_option" 2 (expr length "$desired_option"))
		end
		set -l pattern "-"$desired_option''
                # echo $pattern
	end

	for i in $argv
                # echo $i
                # echo (expr match $i "$pattern")
		if test (expr match $i "$pattern") -ne 0
                        # echo '?'
			return 0
		end
	end

	return 1
end
                                   
