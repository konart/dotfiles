function __gitnow_get_valid_semver_prerelease_value --argument tagv
    command echo $tagv | LC_ALL=C command sed -n 's/^v\\{0,1\\}\([0-9].[0-9].[0-9]-[a-zA-Z0-9\-_.]*\)\([}]*\)/\1/p' 2>/dev/null
end
