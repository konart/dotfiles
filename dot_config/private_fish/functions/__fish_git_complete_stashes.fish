function __fish_git_complete_stashes
    __fish_git stash list --format=%gd:%gs 2>/dev/null | string replace ":" \t
end
