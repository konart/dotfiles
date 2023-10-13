function __fish_toggle_comment_commandline --description 'Comment/uncomment the current command'
    set -l cmdlines (commandline -b)
    if test -z "$cmdlines"
        set cmdlines (history search -p "#" --max=1)
    end
    set -l cmdlines (printf '%s\n' '#'$cmdlines | string replace -r '^##' '')
    commandline -r $cmdlines
    string match -q '#*' $cmdlines[1]
    and commandline -f execute
end
