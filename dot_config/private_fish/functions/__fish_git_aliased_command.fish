function __fish_git_aliased_command
    for word in (string split ' ' -- $argv)
        switch $word
            case !gitk gitk
                echo gitk
                return
                # Adding " to the list
            case '!*' '-*' '*=*' git '()' '{' : '\'*' '"*'
                continue
            case '*'
                echo $word
                return
        end
    end
end
