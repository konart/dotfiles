function show --description 'Gitnow: Show commit detail objects'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "show"
        return
    end

    set -l len (count $argv)

    if test $len -gt 0
        command git show $argv
    else
        command git show --compact-summary --patch HEAD
    end

end
