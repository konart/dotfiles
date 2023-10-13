function stage --description 'Gitnow: Stage files in current working directory'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "stage"
        return
    end

    set -l len (count $argv)
    set -l opts .

    if test $len -gt 0
        set opts $argv
    end

    command git add $opts
end
