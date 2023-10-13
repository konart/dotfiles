function state --description 'Gitnow: Show the working tree status in compact way'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "state"
        return
    end

    command git status -sb
end
