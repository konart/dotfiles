function __fish__git_append_letters_nosep
    set -l token (commandline -tc)
    printf "%s\n" $token$argv
end
