function __fish_git_help_all_concepts
    git help -g | string match -e -r '^   \w+' | while read -l concept desc
        printf "%s\tConcept: %s\n" $concept (string trim $desc)
    end
end
