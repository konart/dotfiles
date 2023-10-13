function __fish_git_global_optspecs
    string join \n v-version h/help C= c=+ 'e-exec-path=?' H-html-path M-man-path I-info-path p/paginate \
        P/no-pager o-no-replace-objects b-bare G-git-dir= W-work-tree= N-namespace= S-super-prefix= \
        l-literal-pathspecs g-glob-pathspecs O-noglob-pathspecs i-icase-pathspecs
end
