function __chezmoi_prepare_completions
    __chezmoi_debug ""
    __chezmoi_debug "========= starting completion logic =========="

    # Start fresh
    set --erase __chezmoi_comp_results

    __chezmoi_perform_completion_once
    __chezmoi_debug "Completion results: $__chezmoi_perform_completion_once_result"

    if test -z "$__chezmoi_perform_completion_once_result"
        __chezmoi_debug "No completion, probably due to a failure"
        # Might as well do file completion, in case it helps
        return 1
    end

    set -l directive (string sub --start 2 $__chezmoi_perform_completion_once_result[-1])
    set --global __chezmoi_comp_results $__chezmoi_perform_completion_once_result[1..-2]

    __chezmoi_debug "Completions are: $__chezmoi_comp_results"
    __chezmoi_debug "Directive is: $directive"

    set -l shellCompDirectiveError 1
    set -l shellCompDirectiveNoSpace 2
    set -l shellCompDirectiveNoFileComp 4
    set -l shellCompDirectiveFilterFileExt 8
    set -l shellCompDirectiveFilterDirs 16

    if test -z "$directive"
        set directive 0
    end

    set -l compErr (math (math --scale 0 $directive / $shellCompDirectiveError) % 2)
    if test $compErr -eq 1
        __chezmoi_debug "Received error directive: aborting."
        # Might as well do file completion, in case it helps
        return 1
    end

    set -l filefilter (math (math --scale 0 $directive / $shellCompDirectiveFilterFileExt) % 2)
    set -l dirfilter (math (math --scale 0 $directive / $shellCompDirectiveFilterDirs) % 2)
    if test $filefilter -eq 1; or test $dirfilter -eq 1
        __chezmoi_debug "File extension filtering or directory filtering not supported"
        # Do full file completion instead
        return 1
    end

    set -l nospace (math (math --scale 0 $directive / $shellCompDirectiveNoSpace) % 2)
    set -l nofiles (math (math --scale 0 $directive / $shellCompDirectiveNoFileComp) % 2)

    __chezmoi_debug "nospace: $nospace, nofiles: $nofiles"

    # If we want to prevent a space, or if file completion is NOT disabled,
    # we need to count the number of valid completions.
    # To do so, we will filter on prefix as the completions we have received
    # may not already be filtered so as to allow fish to match on different
    # criteria than the prefix.
    if test $nospace -ne 0; or test $nofiles -eq 0
        set -l prefix (commandline -t | string escape --style=regex)
        __chezmoi_debug "prefix: $prefix"

        set -l completions (string match -r -- "^$prefix.*" $__chezmoi_comp_results)
        set --global __chezmoi_comp_results $completions
        __chezmoi_debug "Filtered completions are: $__chezmoi_comp_results"

        # Important not to quote the variable for count to work
        set -l numComps (count $__chezmoi_comp_results)
        __chezmoi_debug "numComps: $numComps"

        if test $numComps -eq 1; and test $nospace -ne 0
            # We must first split on \t to get rid of the descriptions to be
            # able to check what the actual completion will be.
            # We don't need descriptions anyway since there is only a single
            # real completion which the shell will expand immediately.
            set -l split (string split --max 1 \t $__chezmoi_comp_results[1])

            # Fish won't add a space if the completion ends with any
            # of the following characters: @=/:.,
            set -l lastChar (string sub -s -1 -- $split)
            if not string match -r -q "[@=/:.,]" -- "$lastChar"
                # In other cases, to support the "nospace" directive we trick the shell
                # by outputting an extra, longer completion.
                __chezmoi_debug "Adding second completion to perform nospace directive"
                set --global __chezmoi_comp_results $split[1] $split[1].
                __chezmoi_debug "Completions are now: $__chezmoi_comp_results"
            end
        end

        if test $numComps -eq 0; and test $nofiles -eq 0
            # To be consistent with bash and zsh, we only trigger file
            # completion when there are no other completions
            __chezmoi_debug "Requesting file completion"
            return 1
        end
    end

    return 0
end
