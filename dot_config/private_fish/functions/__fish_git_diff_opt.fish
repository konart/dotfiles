function __fish_git_diff_opt --argument option
    switch $option
        case diff-algorithm
            printf "%b" "
default\tBasic greedy diff algorithm
myers\tBasic greedy diff algorithm
minimal\tMake smallest diff possible
patience\tPatience diff algorithm
histogram\tPatience algorithm with low-occurrence common elements"
        case diff-filter
            printf "%b" "
A\tAdded files
C\tCopied files
D\tDeleted files
M\tModified files
R\tRenamed files
T\tType changed files
U\tUnmerged files
X\tUnknown files
B\tBroken pairing files"
        case dirstat
            printf "%b" "
changes\tCount lines that have been removed from the source / added to the destination
lines\tRegular line-based diff analysis
files\tCount the number of files changed
cumulative\tCount changes in a child directory for the parent directory as well"
        case ignore-submodules
            printf "%b" "
none\tUntracked/modified files
untracked\tNot considered dirty when they only contain untracked content
dirty\tIgnore all changes to the work tree of submodules
all\tHide all changes to submodules (default)"
        case submodule
            printf "%b" "
short\tShow the name of the commits at the beginning and end of the range
log\tList the commits in the range
diff\tShow an inline diff of the changes"
        case ws-error-highlight
            printf "%b" "
context\tcontext lines of the diff
old\told lines of the diff
new\tnew lines of the diff
none\treset previous values
default\treset the list to 'new'
all\tShorthand for 'old,new,context'"
    end
end
