function __fish_git_tags
    __fish_git tag --sort=-creatordate 2>/dev/null
end
