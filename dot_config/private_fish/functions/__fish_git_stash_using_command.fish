function __fish_git_stash_using_command
    set -l cmd (commandline -opc)
    __fish_git_using_command stash
    or return 2
    # The word after the stash command _must_ be the subcommand
    set cmd $cmd[(contains -i -- "stash" $cmd)..-1]
    set -e cmd[1]
    set -q cmd[1]
    or return 1
    contains -- $cmd[1] $argv
    and return 0
    return 1
end
