function upstream --description 'Gitnow: Commit all changes and push them to remote server'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "upstream"
        return
    end

    commit-all
    push
end
