function __fish_winch_handler --description 'Repaint screen when window changes size' --on-signal SIGWINCH
        if test "$fish_handle_reflow" = 1 2>/dev/null
            commandline -f repaint >/dev/null 2>/dev/null
        end
    
end
