function __fish_git_complete_rev_files
    set -l split (string split -m 1 ":" -- (commandline -ot))
    set -l rev $split[1]
    set -l path $split[2]

    printf "$rev:%s\n" (__fish_git_rev_files $rev $path)
end
