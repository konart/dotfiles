function __fish_git_complete_custom_command --argument subcommand
    set -l cmd (commandline -opc)
    set -e cmd[1] # Drop "git".
    set -l subcommand_args
    if argparse -s (__fish_git_global_optspecs) -- $cmd
        set subcommand_args $argv[2..] # Drop the subcommand.
    end
    complete -C "git-$subcommand $subcommand_args "(commandline -ct)
end
