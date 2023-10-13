function __fish_disable_bracketed_paste --on-event fish_preexec --on-event fish_exit
            printf "\e[?2004l"
        
end
