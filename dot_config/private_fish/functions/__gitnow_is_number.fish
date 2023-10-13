function __gitnow_is_number --argument strv
    command echo -n $strv | LC_ALL=C command grep -qE '^([0-9]+)$'
end
