#!/usr/bin/env fish
if not which -s fisher
    echo "installing fisher"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o /tmp/fisher.fish
    source /tmp/fisher.fish && fisher install jorgebucaran/fisher
end
fisher update
set -l list (fisher list)
for i in (cat fish_plugins)
    if not contains $i in $list
        fisher install $i
    end
end
