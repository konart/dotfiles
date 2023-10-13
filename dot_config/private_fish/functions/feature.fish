function feature --description 'GitNow: Creates a new Gitflow feature branch from current branch' --argument xbranch
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "feature"
        return
    end

    __gitnow_gitflow_branch "feature" $xbranch
end
