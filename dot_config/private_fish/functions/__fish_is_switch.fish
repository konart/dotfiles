function __fish_is_switch
    string match -qr -- '^-' ""(commandline -ct)
end
