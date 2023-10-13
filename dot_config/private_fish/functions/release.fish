function release --description 'GitNow: Creates a new Gitflow release branch from current branch' --argument xbranch
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "release"
        return
    end

    __gitnow_gitflow_branch "release" $xbranch
end
