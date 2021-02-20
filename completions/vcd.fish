# positional arguments
complete -c vcd -f -n "__fish_seen_argument -s h" -a ""
complete -c vcd -f -n "__fish_is_first_token && __fish_not_contain_opt -s h" -a "(__vcd_get_candidate_dirs)"
complete -c vcd -f -n "! __fish_is_first_token" -a ""

# optional arguments
complete -c vcd -n "__fish_not_contain_opt -s h" -s h -l help -d "show help"
