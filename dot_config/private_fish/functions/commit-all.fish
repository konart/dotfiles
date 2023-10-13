function commit-all --description 'Gitnow: Add and commit all changes to the repository'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "commit-all"
        return
    end

    stage
    commit .
end
