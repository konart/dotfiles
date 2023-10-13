function __gitnow_slugify
    echo $argv | LC_ALL=C command iconv -t ascii//TRANSLIT | LC_ALL=C command sed -E 's/[^a-zA-Z0-9\-]+/_/g' | LC_ALL=C command sed -E 's/^(-|_)+|(-|_)+$//g'
end
