function bc --description 'Use bc with the -l flag by default' --wraps bc
	command bc -l $argv
end
