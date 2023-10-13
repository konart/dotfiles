function __fish_git_using_command
    set -l cmd (__fish_git_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd $argv
    and return 0

    # Check aliases.
    set -l varname __fish_git_alias_(string escape --style=var -- $cmd)
    set -q $varname
    and contains -- $$varname[1][1] $argv
    and return 0
    return 1
end
