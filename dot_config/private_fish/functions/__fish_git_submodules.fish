function __fish_git_submodules
    __fish_git submodule 2>/dev/null \
        | string replace -r '^.[^ ]+ ([^ ]+).*$' '$1'
end
