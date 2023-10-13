function __fish_git_diffmerge_tools --argument cmd
    git $cmd --tool-help | while read -l line
        string match -q 'The following tools are valid, but not currently available:' -- $line
        and break
        string replace -f -r '^\t\t(\w+).*$' '$1' -- $line
    end
end
