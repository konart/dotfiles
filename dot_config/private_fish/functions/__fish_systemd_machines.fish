function __fish_systemd_machines
    machinectl --no-legend --no-pager list --all | while read -l a b
        echo $a
    end
end
