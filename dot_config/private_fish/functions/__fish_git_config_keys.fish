function __fish_git_config_keys
    # Print already defined config values first
    # Config keys may span multiple lines, so parse using null char
    # With -z, key and value are separated by space, not "="
    __fish_git config -lz | while read -lz key value
        # Print only first line of value(with an ellipsis) if multiline
        printf '%s\t%s\n' $key (string shorten -N -- $value)
    end
    # Print all recognized config keys; duplicates are not shown twice by fish
    printf '%s\n' (__fish_git help --config)[1..-2] # Last line is a footer; ignore it
end
