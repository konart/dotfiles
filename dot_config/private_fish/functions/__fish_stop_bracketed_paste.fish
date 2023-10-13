function __fish_stop_bracketed_paste
    # Restore the last bind mode.
    set fish_bind_mode $__fish_last_bind_mode
    set -e __fish_paste_quoted
end
