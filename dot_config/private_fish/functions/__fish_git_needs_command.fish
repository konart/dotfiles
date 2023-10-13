function __fish_git_needs_command
    # Figure out if the current invocation already has a command.
    #
    # This is called hundreds of times and the argparse is kinda slow,
    # so we cache it as long as the commandline doesn't change.
    set -l cmdline "$(commandline -c)"
    if set -q __fish_git_cmdline; and test "$cmdline" = "$__fish_git_cmdline"
        if set -q __fish_git_cmd[1]
            echo -- $__fish_git_cmd
            return 1
        end
        return 0
    end
    set -g __fish_git_cmdline $cmdline

    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_git_global_optspecs) -- $cmd 2>/dev/null
    or return 0
    # These flags function as commands, effectively.
    set -q _flag_version; and return 1
    set -q _flag_html_path; and return 1
    set -q _flag_man_path; and return 1
    set -q _flag_info_path; and return 1
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        set -g __fish_git_cmd $argv[1]
        echo $argv[1]
        return 1
    end
    set -g __fish_git_cmd
    return 0
end
