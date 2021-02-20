# positional arguments
complete -c ccd -f -n "__fish_seen_argument -s h" -a ""
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h -s s -s i -s o" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir $CCD_DEFAULT_MODE))"
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h && __fish_seen_argument -s s" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir src))"
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h && __fish_seen_argument -s i" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir install))"
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h && __fish_seen_argument -s o" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir opt))"
complete -c ccd -f -n "! __fish_is_first_token" -a ""

# optional arguments
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s h -l help -d "show help"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s s -l src -d "move under src directory"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s i -l install -d "move under install directory"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s o -l opt -d "move under opt directory"
