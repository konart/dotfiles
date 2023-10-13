function __fish_git_branches
    # This is much faster than using `git branch` and avoids dealing with localized "detached HEAD" messages.
    # We intentionally only sort local branches by recency. See discussion in #9248.
    __fish_git for-each-ref --format='%(refname:strip=2)%09Local Branch' --sort=-committerdate refs/heads/ 2>/dev/null
    __fish_git for-each-ref --format='%(refname:strip=2)%09Remote Branch' refs/remotes/ 2>/dev/null
end
