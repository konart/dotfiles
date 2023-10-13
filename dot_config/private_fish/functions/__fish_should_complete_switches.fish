function __fish_should_complete_switches
    for arg in (commandline -ct)[-1..1]
        if not string match -qr -- "^-\S*\$" "$arg"
            return 1
        end
    end
    if string match -qr -- "^-" (commandline -ct)[-1]
        return 0
    end

    return 1
end
