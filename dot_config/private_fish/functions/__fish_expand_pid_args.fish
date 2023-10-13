function __fish_expand_pid_args
    for arg in $argv
        if string match -qr '^%\d+$' -- $arg
            if not jobs -p $arg
                return 1
            end
        else
            printf "%s\n" $arg
        end
    end
end
