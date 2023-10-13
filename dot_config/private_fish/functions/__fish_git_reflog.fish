function __fish_git_reflog
    __fish_git reflog --no-decorate 2>/dev/null | string replace -r '[0-9a-f]* (.+@\{[0-9]+\}): (.*)$' '$1\t$2'
end
