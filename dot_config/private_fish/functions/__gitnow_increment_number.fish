function __gitnow_increment_number --argument strv
    command echo $strv | LC_ALL=C command awk '
        function increment(val) {
            if (val ~ /[0-9]+/) { return val + 1 }
            return val
        }
        { print increment($0) }
    ' 2>/dev/null
end
