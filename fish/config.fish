function .runsudo --description 'Run current command line as root'
  set cursor_pos (echo (commandline -C) + 5 | bc)
  commandline -C 0
  commandline -i 'sudo '
  commandline -C "$cursor_pos"
end

function .runlesspipe --description 'Pipe current command to less'
  set end_pos (commandline -C)
  commandline -C $end_pos
  commandline -i ' | less'
end

function .fixgit --description 'Fix a mistyped git command'
  set end_pos (commandline -C)
  commandline -C 3
  set current_command (commandline | sed -r s"/"(commandline -c)"//")
  commandline -C 0
  commandline -r 'git'
  commandline -i $current_command 
  commandline -C $end_pos
end

function .fixcommand --description 'Try to fix a mistyped command'
  set full_command (commandline -b)
  set first_command (echo $full_command | cut -d' ' -f1)
  set truncated_first_command (expr substr $first_command 1 (echo (expr length $first_command) - 1 | bc) )
  ls $PATH | grep -h -e "^"$truncated_first_command | tr '\n' ' ' | read -a options
  if test (count $options) = "1"
    set final_command (echo $full_command | sed -r s'/^'$first_command'/'$options[1]'/')
    commandline -r $final_command
  end
end

bash /home/hayden/google-cloud-sdk/path.bash.inc
