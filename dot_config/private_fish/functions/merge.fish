function merge --description 'GitNow: Merges given branch into the active one'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "merge"
        return
    end

    set -l len (count $argv)
    if test $len -eq 0
        echo "Merge: No argument given, needs one parameter"
        return
    end

    set -l v_abort
    set -l v_continue
    set -l v_branch

    for v in $argv
        switch $v
            case -a --abort
                set v_abort $v
            case -c --continue
                set v_continue $v
            case -h --help
                echo "NAME"
                echo "      Gitnow: merge - Merge given branch into the active one"
                echo "EXAMPLES"
                echo "      merge <branch to merge>"
                echo "OPTIONS:"
                echo "      -a --abort              Abort a conflicted merge"
                echo "      -c --continue           Continue a conflicted merge"
                echo "      -h --help               Show information about the options for this command"
                return
            case -\*
            case '*'
                set v_branch $v
        end
    end

    # abort
    if test "$v_abort";
        echo "Abort the current merge"
        command git merge --abort
        return
    end

    # continue
    if test "$v_continue";
        echo "Continue the current merge"
        command git merge --continue
        return
    end

    # No branch defined
    if not test -n "$v_branch"
        echo "Provide a valid branch name to merge."
        return
    end

    set -l v_found (__gitnow_check_if_branch_exist $v_branch)

    # Branch was not found
    if test $v_found -eq 0;
        echo "Local branch `$v_branch` was not found. Not possible to merge."

        return
    end

    # Detect merging current branch
    if [ "$v_branch" = (__gitnow_current_branch_name) ]
        echo "Branch `$v_branch` is the same as current branch. Nothing to do."
        return
    end

    command git merge $v_branch
end
