function __fish_apropos
    set -l dir /var/folders/cq/hwz_n6dd3rl8z2l6k3rhrw2r0000gp/C/fish
        # macOS 10.15 "Catalina" has a read only filesystem where the whatis database should be.
        # The whatis database is non-existent, so apropos tries (and fails) to create it every time,
        # which can take seconds.
        #
        # Instead, we build a whatis database in the user cache directory
        # and override the MANPATH using that directory before we run `apropos`
        #
        # the cache is rebuilt once a week.
        set -l whatis $dir/whatis
        set -l max_age 600000 # like a week
        set -l age $max_age

        if test -f "$whatis"
            set age (path mtime -R -- $whatis)
        end

        MANPATH="$dir" apropos "$argv"

        if test $age -ge $max_age
            test -d "$dir" || mkdir -m 700 -p $dir
            /usr/libexec/makewhatis -o "$whatis" (manpath | string split :) >/dev/null 2>&1 </dev/null &
            disown $last_pid
        end
    
end
