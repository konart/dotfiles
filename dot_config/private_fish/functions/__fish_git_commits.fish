function __fish_git_commits
    # Complete commits with their subject line as the description
    # This allows filtering by subject with the new pager!
    # Because even subject lines can be quite long,
    # trim them (abbrev'd hash+tab+subject) to 73 characters
    #
    # Hashes we just truncate ourselves to 10 characters, without disambiguating.
    # That technically means that sometimes we don't give usable SHAs,
    # but according to https://stackoverflow.com/a/37403152/3150338,
    # that happens for 3 commits out of 600k.
    # For fish, at the time of writing, out of 12200 commits, 7 commits need 8 characters.
    # And since this takes about 1/3rd of the time that disambiguating takes...
    __fish_git log --pretty=tformat:"%H"\t"%<(64,trunc)%s" --all --max-count=1000 2>/dev/null \
        | string replace -r '^([0-9a-f]{10})[0-9a-f]*\t(.*)' '$1\t$2'
end
