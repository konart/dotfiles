function gitnow --description 'Gitnow: Speed up your Git workflow. 🐠' --argument xversion
    if [ "$xversion" = "-v" ]; or [ "$xversion" = "--version" ]
        echo "GitNow version $gitnow_version"
    else
        __gitnow_manual | command less -r
    end
end
