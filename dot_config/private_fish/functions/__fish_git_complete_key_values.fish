function __fish_git_complete_key_values
    set -l config_key (__fish_nth_token 2)

    switch $config_key
        case diff.algorithm
            printf "%s\n" myers patience histogram minimal
        case init.defaultBranch
            printf "%s\n" master main trunk dev next
        case '*'
            __fish_complete_path
    end
end
