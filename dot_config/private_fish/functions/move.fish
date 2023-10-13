function move --description 'GitNow: Switch from current branch to another but stashing uncommitted changes'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "move"
        return
    end

    set -l v_upstream
    set -l v_no_apply_stash
    set -l v_branch

    for v in $argv
        switch $v
            case -u --upstream
                set v_upstream $v
            case -n --no-apply-stash
                set v_no_apply_stash $v
            case -nu -un
                set v_upstream "-u"
                set v_no_apply_stash "-n"
            case -h --help
                echo "NAME"
                echo "      Gitnow: move - Switch from current branch to another but stashing uncommitted changes"
                echo "EXAMPLES"
                echo "      move <branch to switch to>"
                echo "OPTIONS:"
                echo "      -n --no-apply-stash     Switch to a local branch but without applying current stash"
                echo "      -u --upstream           Fetch a remote branch and switch to it applying current stash. It can be combined with --no-apply-stash"
                echo "      -h --help               Show information about the options for this command"
                return
            case -\*
            case '*'
                set v_branch $v
        end
    end

    # No branch defined
    if not test -n "$v_branch"
        echo "Provide a valid branch name to switch to."

        return
    end

    set -l v_fetched 0

    # Fetch branch from remote
    if test -n "$v_upstream"
        set -l v_remote (__gitnow_current_remote)
        command git fetch $v_remote $v_branch:refs/remotes/$v_remote/$v_branch
        command git checkout --track $v_remote/$v_branch
        return
    end

    set -l v_found (__gitnow_check_if_branch_exist $v_branch)

    # Branch was not found
    if begin test $v_found -eq 0; and test $v_fetched -eq 0; end
        echo "Branch `$v_branch` was not found locally. No possible to switch."
        echo "Tip: Use -u (--upstream) flag to fetch a remote branch."

        return
    end

    # Prevent same branch switching
    if [ "$v_branch" = (__gitnow_current_branch_name) ]
        echo "Branch `$v_branch` is the same as current branch. Nothing to do."
        return
    end

    set -l v_uncommited (__gitnow_has_uncommited_changes)

    # Stash changes before checkout for uncommited changes only
    if test $v_uncommited
        command git stash
    end

    command git checkout $v_branch

    # --no-apply-stash
    if test -n "$v_no_apply_stash"
        echo "Stashed changes were not applied. Use `git stash pop` to apply them."
    end

    if begin test $v_uncommited; and not test -n "$v_no_apply_stash"; end
        command git stash pop
        echo "Stashed changes applied."
    end

end
