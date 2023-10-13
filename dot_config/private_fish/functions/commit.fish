function commit --description 'Gitnow: Commit changes to the repository'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "commit"
        return
    end

    set -l len (count $argv)

    if test $len -gt 0
        command git commit $argv
    else
        command git commit
    end

end
