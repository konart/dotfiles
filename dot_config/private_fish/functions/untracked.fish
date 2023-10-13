function untracked --description 'Gitnow: Check for untracked files and directories on current working directory'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "untracked"
        return
    end

    command git clean --dry-run -d

end
