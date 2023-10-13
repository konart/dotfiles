function __fish_is_nth_token --description 'Test if current token is the Nth (ignoring command and switches/flags)' --argument n
    set -l tokens (commandline -poc)
    set -l tokens (string replace -r --filter '^([^-].*)' '$1' -- $tokens)
    test (count $tokens) -eq "$n"
end
