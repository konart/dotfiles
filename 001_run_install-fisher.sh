#!/bin/sh
echo test 
which -s fisher
if [[ $? != 0 ]] ; then
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fi
if [[ $(fisher list) ]]; then
    fisher update
else
    fisher install <<EOF
    jorgebucaran/fisher
    jethrokuan/z
    jhillyerd/plugin-git
    oh-my-fish/plugin-brew
    oh-my-fish/plugin-osx
    oh-my-fish/plugin-rvm
    edc/bass
    patrickf1/fzf.fish
    EOF
fi
