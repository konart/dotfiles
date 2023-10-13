function __fish_git_sort_keys
    echo -objectsize\tSize of branch or commit
    echo -authordate\tWhen the latest commit was actually made
    echo -committerdate\tWhen the branch was last committed or rebased
    echo -creatordate\tWhen the latest commit or tag was created
    echo creator\tThe name of the commit author
    echo objectname\tThe complete SHA1
    echo objectname:short\tThe shortest non-ambiguous SHA1
    echo refname\tThe complete, unambiguous git ref name
    echo refname:short\tThe shortest non-ambiguous ref name
    echo author\tThe name of the author of the latest commit
    echo committer\tThe name of the person who committed latest
    echo tagger\tThe name of the person who created the tag
    echo authoremail\tThe email of the author of the latest commit
    echo committeremail\tThe email of the person who committed last
    echo taggeremail\tThe email of the person who created the tag
end
