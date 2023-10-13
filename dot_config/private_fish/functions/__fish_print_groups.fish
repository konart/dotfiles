function __fish_print_groups --description 'Print a list of local groups'
    # Leave the heavy lifting to __fish_complete_groups but strip the descriptions.
    __fish_complete_groups | string replace -r '^([^\t]*)\t.*' '$1'
end
