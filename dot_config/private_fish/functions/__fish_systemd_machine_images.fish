function __fish_systemd_machine_images
    machinectl --no-legend --no-pager list-images | while read -l a b
        echo $a
    end
end
