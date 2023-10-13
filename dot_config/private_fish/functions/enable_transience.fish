function enable_transience --description 'enable transient prompt keybindings'
    bind --user \r transient_execute
    bind --user -M insert \r transient_execute
end
