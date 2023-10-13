function __gitnow_gitflow_branch --argument xprefix xbranch
    set xbranch (__gitnow_slugify $xbranch)
    set -l xbranch_full "$xprefix/$xbranch"
    set -l xfound (__gitnow_check_if_branch_exist $xbranch_full)

    if test $xfound -eq 1
        echo "Branch `$xbranch_full` already exists. Nothing to do."
    else
        command git stash
        __gitnow_new_branch_switch "$xbranch_full"
        command git stash pop
    end
end
