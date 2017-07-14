function dev-down -d 'Halt the Bond St dev env.'
    pushd ~/gits/bondstreet_devops
    vagrant halt dev
    popd
end

