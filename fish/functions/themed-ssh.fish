function themed-ssh -d 'Change terminal theme for certain SSH hosts'
  # see below for why signals don't work
  # trap tabreset int exit quit kill stop term

  if test $argv[1] = "prod"
    tabc Prod
  else if test $argv[1] = "staging"
    tabc Staging
  else
    tabc
  end

  command ssh $argv

  # signals don't do so hot in Fish, but since SSH blocks, we can just jam this
  # down here and profit. See: https://github.com/fish-shell/fish-shell/issues/2036
  # for more info.
  tabreset
end
