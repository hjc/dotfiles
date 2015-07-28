function fish_prompt -d 'Write out the prompt'
    set_color purple
    printf (whoami)
    set_color red
    printf '@'
    set_color green
    printf (hostname)
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
