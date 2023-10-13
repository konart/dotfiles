function __fish_git_possible_commithash
    set -q argv[1]
    and set -l token $argv[1]
    or set -l token (commandline -ct)
    if string match -qr '^[0-9a-fA-F]{3,}$' -- $token
        return 0
    end
    return 1
end
