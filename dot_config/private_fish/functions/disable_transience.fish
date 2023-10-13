function disable_transience --description 'remove transient prompt keybindings'
    bind --user -e \r
    bind --user -M insert -e \r
end
