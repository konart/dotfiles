function tag --description 'Gitnow: Tag commits following Semver'
    if not __gitnow_is_git_repository
        __gitnow_msg_not_valid_repository "tag"
        return
    end

    set -l v_major
    set -l v_minor
    set -l v_patch
    set -l v_premajor
    set -l v_preminor
    set -l v_prepatch

    set -l opts

    # NOTE: this function only gets the latest *Semver release version* but no suffixed ones or others
    set -l v_latest (__gitnow_get_latest_semver_release_tag)

    for v in $argv
        switch $v
            case -x --major
                set v_major $v
            case -y --minor
                set v_minor $v
            case -z --patch
                set v_patch $v
            case -a --annotate
                set opts $opts $v

            # TODO: pre-release versions are not supported yet
            # case -a --premajor
            #     set v_premajor $v
            # case -b --preminor
            #     set v_preminor $v
            # case -c --prepatch
            #     set v_prepatch $v

            case -l --latest
                if not test -n "$v_latest"
                    echo "There is no any tag created yet."
                else
                    echo $v_latest
                end

                return
            case -h --help
                echo "NAME"
                echo "      Gitnow: tag - List or tag commits following The Semantic Versioning 2.0.0 (Semver) [1]"
                echo "      [1] https://semver.org/"
                echo "EXAMPLES"
                echo "      List tags: tag"
                echo "      Custom tag: tag <my tag name>"
                echo "      Semver tag: tag --major"
                echo "OPTIONS:"
                echo "      Without options all tags are listed in a lexicographic order and tag names are treated as versions"
                echo "      -x --major         Tag auto-incrementing a major version number"
                echo "      -y --minor         Tag auto-incrementing a minor version number"
                echo "      -z --patch         Tag auto-incrementing a patch version number"
                echo "      -l --latest        Show only the latest Semver release tag version (no suffixed ones or others)"
                echo "      -a --annotate      Create as annotated tag"
                echo "      -h --help          Show information about the options for this command"

                # TODO: pre-release versions are not supported yet
                # echo "      -a --premajor      Tag auto-incrementing a premajor version number"
                # echo "      -b --preminor      Tag auto-incrementing a preminor version number"
                # echo "      -c --prepatch      Tag auto-incrementing a prepatch version number"

                return
            case -\*
            case '*'
                return
        end
    end

    # List all tags in a lexicographic order and treating tag names as versions
    if test -z "$argv"
        __gitnow_get_tags_ordered
        return
    end

    # Major version tags
    if test -n "$v_major"
        if not test -n "$v_latest"
            command git tag $opts v1.0.0
            echo "First major tag \"v1.0.0\" was created."
            return
        else
            set -l vstr (__gitnow_get_valid_semver_release_value $v_latest)

            # Validate Semver format before to proceed
            if not test -n "$vstr"
                echo "The latest tag \"$v_latest\" has no a valid Semver format."
                return
            end

            set -l x (echo $vstr | LC_ALL=C command awk -F '.' '{print $1}')
            set -l prefix (echo $v_latest | LC_ALL=C command awk -F "$vstr" '{print $1}')
            set x (__gitnow_increment_number $x)
            set -l xyz "$prefix$x.0.0"

            command git tag $opts $xyz
            echo "Major tag \"$xyz\" was created."
            return
        end
    end


    # Minor version tags
    if test -n "$v_minor"
        if not test -n "$v_latest"
            command git tag $opts v0.1.0
            echo "First minor tag \"v0.1.0\" was created."
            return
        else
            set -l vstr (__gitnow_get_valid_semver_release_value $v_latest)

            # Validate Semver format before to proceed
            if not test -n "$vstr"
                echo "The latest tag \"$v_latest\" has no a valid Semver format."
                return
            end

            set -l x (echo $vstr | LC_ALL=C command awk -F '.' '{print $1}')
            set -l y (echo $vstr | LC_ALL=C command awk -F '.' '{print $2}')
            set -l prefix (echo $v_latest | LC_ALL=C command awk -F "$vstr" '{print $1}')
            set y (__gitnow_increment_number $y)
            set -l xyz "$prefix$x.$y.0"

            command git tag $opts $xyz
            echo "Minor tag \"$xyz\" was created."
            return
        end
    end


    # Patch version tags
    if test -n "$v_patch"
        if not test -n "$v_latest"
            command git tag $opts v0.0.1
            echo "First patch tag \"v0.1.0\" was created."
            return
        else
            set -l vstr (__gitnow_get_valid_semver_release_value $v_latest)

            # Validate Semver format before to proceed
            if not test -n "$vstr"
                echo "The latest tag \"$v_latest\" has no a valid Semver format."
                return
            end

            set -l x (echo $vstr | LC_ALL=C command awk -F '.' '{print $1}')
            set -l y (echo $vstr | LC_ALL=C command awk -F '.' '{print $2}')
            set -l z (echo $vstr | LC_ALL=C command awk -F '.' '{print $3}')
            set -l s (echo $z | LC_ALL=C command awk -F '-' '{print $1}')

            if __gitnow_is_number $s
                set -l prefix (echo $v_latest | LC_ALL=C command awk -F "$vstr" '{print $1}')
                set s (__gitnow_increment_number $s)
                set -l xyz "$prefix$x.$y.$s"

                command git tag $opts $xyz
                echo "Patch tag \"$xyz\" was created."
            else
                echo "No patch version found."
            end

            return
        end
    end


    # TODO: pre-release versions are not supported yet
    # TODO: Premajor version tags
    # TODO: Preminor version tags
    # TODO: Prepatch version tags


end
