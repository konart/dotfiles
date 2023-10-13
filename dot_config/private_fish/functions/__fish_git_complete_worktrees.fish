function __fish_git_complete_worktrees
    __fish_git worktree list --porcelain | string replace --regex --filter '^worktree\s*' ''
end
