function __fish_complete_directories --description 'Complete directory prefixes' --argument comp desc
    if not set -q desc[1]
        set desc Directory
    end

    if not set -q comp[1]
        set comp (commandline -ct)
    end

    # HACK: We call into the file completions by using an empty command
    # If we used e.g. `ls`, we'd run the risk of completing its options or another kind of argument.
    # But since we default to file completions, if something doesn't have another completion...
    # (really this should have an actual complete option)
    set -l dirs (complete -C"'' $comp" | string match -r '.*/$')

    if set -q dirs[1]
        printf "%s\n" $dirs\t"$desc"
    end
end
