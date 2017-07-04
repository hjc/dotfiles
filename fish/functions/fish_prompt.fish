# fish git prompt
# @TODO; these customize some... things. Usse them?
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showupstream 'yes'
# set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'


function fish_prompt -d 'Write out the prompt'
    set_color purple
    printf (whoami)
    set_color red
    printf '@'
    set_color green
    printf (hostname)
    __in_git_repo
    set in_git_repo $status
    if test $in_git_repo -eq 0
        set_color E2E270
        printf '%s ' (__fish_git_prompt)
        printf ' ('(__git_extract_branch_name)')'
        set_color normal
    end
    set_color blue
    printf ' {'
    set_color yellow
    printf (pwd | sed -r s"!"$HOME"!~!")
    set_color blue
    printf '} '
    set_color cyan
    printf '~> '
    set_color normal
end

function __in_git_repo -d "Runs git status to see if we're in a git repo"
    git status > /dev/null ^ /dev/null
    return (test $status -ne 128)
end

function __git_extract_branch_name -d "Extracts the current branch name"
    # use git status --porcelain for predictable output. Then find the branch
    #   specifier, strip some pretty printing from it, and finally, print the
    #   reference to the upstream branch (which looks like: develop...origin/develop)
    echo (git status -b --porcelain | grep '##' | sed -r s'/## //' | sed -r s'/\.\.\..*//')
end
