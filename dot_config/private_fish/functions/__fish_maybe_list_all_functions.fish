function __fish_maybe_list_all_functions
    # if the current commandline token starts with an _, list all functions
    if string match -qr -- '^_' (commandline -ct)
        functions -an
    else
        functions -n
    end
end
