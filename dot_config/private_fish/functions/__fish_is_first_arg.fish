function __fish_is_first_arg
    set -l tokens (commandline -poc)
    test (count $tokens) -eq 1
end
