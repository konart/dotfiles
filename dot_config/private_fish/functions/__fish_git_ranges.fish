function __fish_git_ranges
    set -l both (commandline -ot | string replace -r '\.{2,3}' \n\$0\n)
    set -l from $both[1]
    set -l dots $both[2]
    # If we didn't need to split (or there's nothing _to_ split), complete only the first part
    # Note that status here is from `string replace` because `set` doesn't alter it
    if test -z "$from" -o $status -gt 0
        if commandline -ct | string match -q '*..*'
            # The cursor is right of a .. range operator, make sure to include them first.
            __fish_git_refs | string replace -r '' "$dots"
        else
            __fish_git_refs | string replace \t "$dots"\t
        end
        return 0
    end

    set -l from_refs
    if commandline -ct | string match -q '*..*'
        # If the cursor is right of a .. range operator, only complete the right part.
        set from_refs $from
    else
        set from_refs (__fish_git_refs | string match -e "$from" | string replace -r \t'.*$' '')
    end

    set -l to $both[3]
    # Remove description from the from-ref, not the to-ref.
    for from_ref in $from_refs
        for to_ref in (__fish_git_refs | string match "*$to*") # if $to is empty, this correctly matches everything
            printf "%s%s%s\n" $from_ref $dots $to_ref
        end
    end
end
