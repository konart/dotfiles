function bugfix --description 'GitNow: Creates a new Gitflow bugfix branch from current branch' --argument xbranch
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "bugfix"
        return
    end

    __gitnow_gitflow_branch "bugfix" $xbranch
end
