function __z_legacy_escape_regex
        # taken from escape_string_pcre2 in fish
        # used to provide compatibility with fish 2
        for c in (string split '' $argv)
            if contains $c (string split '' '.^$*+()?[{}\\|-]')
                printf \\
            end
            printf '%s' $c
        end
    
end
