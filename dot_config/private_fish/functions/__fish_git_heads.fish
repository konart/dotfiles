function __fish_git_heads
    set -l gitdir (__fish_git rev-parse --git-dir 2>/dev/null)
    or return # No git dir, no need to even test.
    for head in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD
        if test -f $gitdir/$head
            echo $head
        end
    end
end
