function __fish_git_show_opt --argument option
    switch $option
        case format pretty
            printf "%b" "
oneline\t<sha1> <title line>
short\t<sha1> / <author> / <title line>
medium\t<sha1> / <author> / <author date> / <title> / <commit msg>
full\t<sha1> / <author> / <committer> / <title> / <commit msg>
fuller\t<sha1> / <author> / <author date> / <committer> / <committer date> / <title> / <commit msg>
email\t<sha1> <date> / <author> / <author date> / <title> / <commit msg>
raw\tShow the entire commit exactly as stored in the commit object
format:\tSpecify which information to show"
    end
end
