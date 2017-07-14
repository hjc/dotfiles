function tabc -d 'Change current terminal profile'
    # @TODO: Implement for Linux and Terminator
    if test (uname -s) != "Darwin"
        return
    end

    set -l name $argv[1]

    if test -z $name
        set -l name "Default"
    end

    echo -ne "\033]50;SetProfile="$name"\a"
end

