function __chezmoi_requires_order_preservation
    __chezmoi_debug ""
    __chezmoi_debug "========= checking if order preservation is required =========="

    __chezmoi_perform_completion_once
    if test -z "$__chezmoi_perform_completion_once_result"
        __chezmoi_debug "Error determining if order preservation is required"
        return 1
    end

    set -l directive (string sub --start 2 $__chezmoi_perform_completion_once_result[-1])
    __chezmoi_debug "Directive is: $directive"

    set -l shellCompDirectiveKeepOrder 32
    set -l keeporder (math (math --scale 0 $directive / $shellCompDirectiveKeepOrder) % 2)
    __chezmoi_debug "Keeporder is: $keeporder"

    if test $keeporder -ne 0
        __chezmoi_debug "This does require order preservation"
        return 0
    end

    __chezmoi_debug "This doesn't require order preservation"
    return 1
end
