function __fish_git_recent_commits
    # Like __fish_git_commits, but not on all branches and limited to
    # the last 50 commits. Used for fixup, where only the current branch
    # and the latest commits make sense.
    __fish_git log --pretty=tformat:"%h"\t"%<(64,trunc)%s" --max-count=50 $argv 2>/dev/null
end
