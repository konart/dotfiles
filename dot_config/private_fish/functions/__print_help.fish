function __print_help --description 'Print z help.'
        printf "Usage: $Z_CMD  [-celrth] string1 string2...\n\n"
        printf "         -c --clean    Removes directories that no longer exist from $Z_DATA\n"
        printf "         -d --dir      Opens matching directory using system file manager.\n"
        printf "         -e --echo     Prints best match, no cd\n"
        printf "         -l --list     List matches and scores, no cd\n"
        printf "         -p --purge    Delete all entries from $Z_DATA\n"
        printf "         -r --rank     Search by rank\n"
        printf "         -t --recent   Search by recency\n"
        printf "         -x --delete   Removes the current directory from $Z_DATA\n"
        printf "         -h --help     Print this help\n\n"
    
end
