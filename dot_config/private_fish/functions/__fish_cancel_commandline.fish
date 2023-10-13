function __fish_cancel_commandline
    set -l cmd (commandline)
    if test -n "$cmd"
        echo -sn $__fish_cancel_text
        # `commandline -L` prints the line the cursor is on (starting from the prompt), so move the cursor
        # "to the end" then call `commandline -L` to get the total number of lines typed in at the prompt.
        commandline -C 10000000
        printf (string repeat -n (commandline -L) "\n")
        commandline ""
        emit fish_cancel
    end

    # cancel: Close the pager if it's open (#4298)
    # repaint: Repaint even if we haven't cancelled anything so the prompt refreshes
    # and the terminal scrolls to it.
    commandline -f cancel -f repaint
end
