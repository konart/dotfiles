function __fish_enable_bracketed_paste --on-event fish_prompt --on-event fish_read
            printf "\e[?2004h"
        
end
