function __fish_commandline_insert_escaped --description 'Insert the first arg escaped if a second arg is given'
    if set -q argv[2]
        commandline -i \\$argv[1]
    else
        commandline -i $argv[1]
    end
end
