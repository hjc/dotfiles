function git-up -d 'cd to top level of a git repo'
    cd (git rev-parse --show-toplevel)
end

