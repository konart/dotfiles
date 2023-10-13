function __fish_git_is_rebasing
    test -e (__fish_git rev-parse --absolute-git-dir)/rebase-merge
end
