function __fish_git_unique_remote_branches
    # `git checkout` accepts remote branches without the remote part
    # if they are unambiguous.
    # E.g. if only alice has a "frobulate" branch
    # `git checkout frobulate` is equivalent to `git checkout -b frobulate --track alice/frobulate`.
    __fish_git for-each-ref --format="%(refname:strip=3)" \
        --sort="refname:strip=3" \
        "refs/remotes/*/$match*" "refs/remotes/*/*/**" 2>/dev/null | uniq -u
end
