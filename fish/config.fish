function .runsudo --description 'Run current command line as root'
  set cursor_pos (echo (commandline -C) + 5 | bc)
  commandline -C 0
  commandline -i 'sudo '
  commandline -C "$cursor_pos"
end

function .runlesspipe --description 'Pipe current command to less'
  set end_pos (math (commandline | wc -m) + 2)
  commandline -C $end_pos
  commandline -i ' | less'
end

function .fixgit --description 'Fix a mistyped git command'
  set end_pos (commandline -C)
  commandline -C 3
  set current_command (commandline)
  if test $current_command = ""
    commandline -r 'git '
    return 0
  end
  set current_command (echo $current_command | sed -r s"/"(commandline -c)"//")
  commandline -C 0
  commandline -r 'git '
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

# @TODO: what does this do? does it include Google Cloud helpers? does it work?
if test -f ~/google-cloud-sdk/path.bash.inc
  bash ~/google-cloud-sdk/path.bash.inc
end

# make sure sbin's are in $PATH, which they are not by default in Debian
if test (which lsb_release); and test (lsb_release -is) = "Debian"
  set -gx PATH /usr/sbin /sbin $PATH
end

# @TODO: ????????????
set -gx CWD (pwd)

if test (which powerline-setup)
  # Add powerline stuff to Fish's function path so we can use it
  set fish_function_path $fish_function_path "/usr/local/lib/python2.7/dist-packages/powerline/bindings/fish"
  # and launch powerline
  powerline-setup
end

# some fixes to make Go work
if test -d $HOME/go
  set -gx GOPATH $HOME/go
  set -gx PATH $GOPATH/bin $PATH
end

if test -d $HOME/.pyenv
  set -gx PYENV_ROOT $HOME/.pyenv
  set -gx PATH {$PYENV_ROOT}/bin $PATH
end

if test (which pyenv)
  status --is-interactive; and source (pyenv init -|psub)
end

ulimit -n 8096
