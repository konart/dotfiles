function bitbucket --description 'Gitnow: Clone a Bitbucket Cloud repository using SSH'
    set -l repo (__gitnow_clone_params $argv)
    __gitnow_clone_repo $repo "bitbucket"

end
