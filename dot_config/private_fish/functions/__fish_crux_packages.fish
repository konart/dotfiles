function __fish_crux_packages --description 'Obtain a list of installed packages'
    pkginfo -i | string split -f1 ' '
end
