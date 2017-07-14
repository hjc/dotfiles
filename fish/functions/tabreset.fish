function tabreset -d 'Reset terminal profile to default.'
    # @TODO: Implement for Linux and Terminator
    if test (uname -s) != "Darwin"
        return
    end

    set -l name "Default"
    echo -ne "\033]50;SetProfile="$name"\a"
end

