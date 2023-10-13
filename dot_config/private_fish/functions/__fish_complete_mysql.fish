function __fish_complete_mysql
    set -l command $argv[1]

    complete -c $command -s D -l database -x -d 'The database to use' -a '(__fish_complete_mysql_databases)'
    complete -c $command -a '(__fish_complete_mysql_databases)'
end
