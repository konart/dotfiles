function __fish_git_aliases
    __fish_git config -z --get-regexp '^alias\.' 2>/dev/null | while read -lz key value
        begin
            set -l name (string replace -r '^.*\.' '' -- $key)
            set -l val (string shorten --no-newline -m 36 -- $value)
            printf "%s\t%s\n" $name "alias: $val"
        end
    end
end
