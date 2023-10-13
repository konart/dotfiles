function assume --description 'Gitnow: Ignore files temporarily'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "assume"
        return
    end

    set -l v_assume_unchanged "--assume-unchanged"
    set -l v_files

    for v in $argv
        switch $v
            case -n --no-assume
                set v_assume_unchanged "--no-assume-unchanged"
            case -h --help
                echo "NAME"
                echo "      Gitnow: assume - Ignores changes in certain files temporarily"
                echo "OPTIONS:"
                echo "      -n --no-assume  No assume unchanged files to be ignored (revert option)"
                echo "      -h --help       Show information about the options for this command"
                return
            case -\*
            case '*'
                set v_files $v_files $v
        end
    end

    if test (count $v_files) -lt 1
        echo "Provide files in order to ignore them temporarily. E.g `assume Cargo.lock`"
        return
    end

    command git update-index $v_assume_unchanged $v_files
end
