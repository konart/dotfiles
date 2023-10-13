function _fzf_uninstall_bindings
    set -l key_sequences \e\cf \e\cl \e\cs \cr \cv \e\cp
            bind --erase -- $key_sequences
            bind --erase --mode insert -- $key_sequences
        
end
