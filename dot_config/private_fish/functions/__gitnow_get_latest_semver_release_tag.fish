function __gitnow_get_latest_semver_release_tag
    for tg in (__gitnow_get_tags_ordered)
        if echo $tg | LC_ALL=C command grep -qE '^v?([0-9]+).([0-9]+).([0-9]+)$'
            echo $tg 2>/dev/null
            break
        end
    end
end
