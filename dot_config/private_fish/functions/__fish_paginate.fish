function __fish_paginate --description 'Paginate the current command using the users default pager'
    set -l cmd less
    if set -q PAGER
        echo $PAGER | read -at cmd
    end

    fish_commandline_append " &| $cmd"
end
