function __fish_complete_users --description 'Print a list of local users, with the real user name as a description'
    if command -sq getent
        command getent passwd | while read -l line
            string split -f 1,5 : -- $line | string join \t | string replace -r ',.*' ''
        end
    else if command -sq dscl
        # This is the "Directory Service command line utility" used on macOS in place of getent.
        command dscl . -list /Users RealName | string match -r -v '^_' | string replace -r ' {2,}' \t
    else if test -r /etc/passwd
        string match -v -r '^\s*#' </etc/passwd | while read -l line
            string split -f 1,5 : -- $line | string join \t | string replace -r ',.*' ''
        end
    end
end
