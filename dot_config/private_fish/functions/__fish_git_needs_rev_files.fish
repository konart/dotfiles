function __fish_git_needs_rev_files
    # git (as of 2.20) accepts the rev:path syntax for a number of subcommands,
    # but then doesn't emit the expected (or any?) output, e.g. `git log master:foo`
    #
    # This definitely works with `git show` to retrieve a copy of a file as it exists
    # in the index of revision $rev, it should be updated to include others as they
    # are identified.
    __fish_git_using_command show; and string match -r "^[^-].*:" -- (commandline -ot)
end
