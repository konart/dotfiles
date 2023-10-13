function __chezmoi_perform_completion_once
    __chezmoi_debug "Starting __chezmoi_perform_completion_once"

    if test -n "$__chezmoi_perform_completion_once_result"
        __chezmoi_debug "Seems like a valid result already exists, skipping __chezmoi_perform_completion"
        return 0
    end

    set --global __chezmoi_perform_completion_once_result (__chezmoi_perform_completion)
    if test -z "$__chezmoi_perform_completion_once_result"
        __chezmoi_debug "No completions, probably due to a failure"
        return 1
    end

    __chezmoi_debug "Performed completions and set __chezmoi_perform_completion_once_result"
    return 0
end
