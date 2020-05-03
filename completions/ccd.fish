# positional arguments
complete -c ccd -f -n "__fish_contains_opt -s h" -a ""
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h -s s -s i" -a "(__ccd_get_candidate_pkgs $CCD_DEFAULT_MODE)"
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h && __fish_contains_opt -s s" -a "(__ccd_get_candidate_pkgs src)"
complete -c ccd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h && __fish_contains_opt -s i" -a "(__ccd_get_candidate_pkgs install)"
complete -c ccd -f -n "! __fish_is_first_token" -a ""

# optional arguments
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i" -s h -l help -d "show help"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i" -s s -l src -d "move under src directory"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i" -s i -l install -d "move under install directory"
