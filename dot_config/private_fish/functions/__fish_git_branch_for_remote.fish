function __fish_git_branch_for_remote
    set -l remotes (__fish_git_remotes)
    set -l remote
    set -l cmd (commandline -opc)
    for r in $remotes
        if contains -- $r $cmd
            set remote $r
            break
        end
    end
    set -q remote[1]
    or return 1
    __fish_git_branches | string replace -f -- "$remote/" ''
end
