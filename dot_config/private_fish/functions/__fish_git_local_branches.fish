function __fish_git_local_branches
    __fish_git for-each-ref --format='%(refname:strip=2)%09Local Branch' --sort=-committerdate refs/heads/ 2>/dev/null
end
