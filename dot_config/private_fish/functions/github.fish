function github --description 'Gitnow: Clone a GitHub repository using SSH'
    set -l repo (__gitnow_clone_params $argv)
    __gitnow_clone_repo $repo "github"

end
