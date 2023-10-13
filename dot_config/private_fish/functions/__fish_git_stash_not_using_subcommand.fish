function __fish_git_stash_not_using_subcommand
    set -l cmd (commandline -opc)
    __fish_git_using_command stash
    or return 2
    set cmd $cmd[(contains -i -- "stash" $cmd)..-1]
    set -q cmd[2]
    and return 1
    return 0
end
