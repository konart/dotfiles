function transient_execute
    if commandline --is-valid
        set -g TRANSIENT 1
        commandline -f repaint
    else
        set -g TRANSIENT 0
    end
    commandline -f execute
end
