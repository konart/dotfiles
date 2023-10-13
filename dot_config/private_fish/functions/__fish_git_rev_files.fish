function __fish_git_rev_files
    set -l rev $argv[1]
    set -l path $argv[2]

    # Strip any partial files from the path before handing it to `git show`
    set -l path (string replace -r -- '(.*/|).*' '$1' $path)

    # List files in $rev's index, skipping the "tree ..." header, but appending
    # the parent path, which git does not include in the output (and fish requires)
    string join \n -- $path(__fish_git show $rev:$path | sed '1,2d')
end
