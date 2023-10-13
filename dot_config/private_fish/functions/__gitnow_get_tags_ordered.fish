function __gitnow_get_tags_ordered
    command git -c 'versionsort.suffix=-' tag --list --sort=-version:refname
end
