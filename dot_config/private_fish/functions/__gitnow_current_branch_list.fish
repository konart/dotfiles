function __gitnow_current_branch_list
    command git branch --list --no-color | LC_ALL=C command sed -E "s/^(\*?[ \t]*)//g" 2>/dev/null
end
