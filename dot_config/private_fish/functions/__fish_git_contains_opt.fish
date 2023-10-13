function __fish_git_contains_opt
    # Check if an option has been given
    # First check the commandline normally
    __fish_contains_opt $argv
    and return

    # Now check the alias
    argparse s= -- $argv
    set -l cmd (__fish_git_needs_command)
    set -l varname __fish_git_alias_(string escape --style=var -- $cmd)
    if set -q $varname
        echo -- $$varname | read -lat toks
        set toks (string replace -r '(-.*)=.*' '' -- $toks)
        for i in $argv
            if contains -- --$i $toks
                return 0
            end
        end

        for i in $_flag_s
            if string match -qr -- "^-$i|^-[^-]*$i" $toks
                return 0
            end
        end
    end

    return 1
end
