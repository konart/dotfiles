function __fish_commandline_is_singlequoted --description 'Return 0 if the current token has an open single-quote'
    string match -q 'single*' (__fish_tokenizer_state -- (commandline -ct | string collect))
end
