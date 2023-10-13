set -gx TERM xterm-256color;

set -Ux GOPATH $HOME/build/go
set -Ux GOROOT /usr/local/opt/go/libexec

if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
fish_vi_key_bindings

fish_add_path ~/build/go/bin/
fish_add_path ~/.cargo/bin/

set -U fish_color_autosuggestion 696969
set -U fish_color_cancel \x2d\x2dreverse
set -U fish_color_command dea050
set -U fish_color_comment 696969
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end normal
set -U fish_color_error red
set -U fish_color_escape c24d43
set -U fish_color_history_current \x2d\x2dbold
set -U fish_color_host normal
set -U fish_color_host_remote \x1d
set -U fish_color_keyword c24d43
set -U fish_color_match \x2d\x2dbackground\x3dbrblue
set -U fish_color_normal normal
set -U fish_color_operator c24d43
set -U fish_color_option \x1d
set -U fish_color_param normal
set -U fish_color_quote bab972
set -U fish_color_redirection c24d43
set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dblue
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline
set -U fish_pager_color_background \x1d
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D
set -U fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
set -U fish_pager_color_secondary_background \x1d
set -U fish_pager_color_secondary_completion \x1d
set -U fish_pager_color_secondary_description \x1d
set -U fish_pager_color_secondary_prefix \x1d
set -U fish_pager_color_selected_background \x2d\x2dbackground\x3dbrblack
set -U fish_pager_color_selected_completion \x1d
set -U fish_pager_color_selected_description \x1d
set -U fish_pager_color_selected_prefix \x1d

pyenv init - | source
