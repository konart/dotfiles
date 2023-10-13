function __fish_start_bracketed_paste
    # Save the last bind mode so we can restore it.
    set -g __fish_last_bind_mode $fish_bind_mode
    # If the token is currently single-quoted,
    # we escape single-quotes (and backslashes).
    string match -q 'single*' (__fish_tokenizer_state -- (commandline -ct | string collect))
    and set -g __fish_paste_quoted 1
end
