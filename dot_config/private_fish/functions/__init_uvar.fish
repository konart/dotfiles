function __init_uvar --description Sets\ a\ universal\ variable\ if\ it\'s\ not\ already\ set
        if not set --query $argv[1]
            set --universal $argv
        end
    
end
