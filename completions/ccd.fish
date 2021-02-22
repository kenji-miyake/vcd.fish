function __contains_pkg_name
    set -l cursor (commandline -tc)

    if string match -q -r -- "\/" "$cursor"
        return 0
    end

    return 1
end

function __get_package_subdirs --argument-names ccd_mode
    set -l cursor (commandline -tc)
    set -l package_name (string replace -a -r -- "^(\w+)\/.*" "\$1" "$cursor")
    set -l package_path (string replace -a -r -- "\/\w*\$" "" "$cursor")

    set base_dir (__ccd_get_base_dir $ccd_mode)
    set package_dir (__ccd_find_package_dir $package_path $base_dir)
    set fullpath_dirs (__fish_complete_directories $package_dir/)

    set -l output (string replace -- "$package_dir" "$package_path" $fullpath_dirs)

    printf "%s\n" $output
end

# positional arguments
complete -c ccd -f -n "__fish_seen_argument -s h" -a ""
complete -c ccd -f -n "__fish_is_first_token && not __contains_pkg_name &&__fish_not_contain_opt -s h -s s -s i -s o" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir $CCD_DEFAULT_MODE))/"
complete -c ccd -f -n "__fish_is_first_token && not __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s s" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir src))/"
complete -c ccd -f -n "__fish_is_first_token && not __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s i" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir install))/"
complete -c ccd -f -n "__fish_is_first_token && not __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s o" -a "(__ccd_get_candidate_pkgs (__ccd_get_base_dir opt))/"
complete -c ccd -f -n "__fish_is_first_token && __contains_pkg_name &&__fish_not_contain_opt -s h -s s -s i -s o" -a "(__get_package_subdirs $CCD_DEFAULT_MODE)/"
complete -c ccd -f -n "__fish_is_first_token && __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s s" -a "(__get_package_subdirs src)/"
complete -c ccd -f -n "__fish_is_first_token && __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s i" -a "(__get_package_subdirs install)/"
complete -c ccd -f -n "__fish_is_first_token && __contains_pkg_name &&__fish_not_contain_opt -s h && __fish_seen_argument -s o" -a "(__get_package_subdirs opt)/"
complete -c ccd -f -n "! __fish_is_first_token" -a ""

# optional arguments
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s h -l help -d "show help"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s s -l src -d "move under src directory"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s i -l install -d "move under install directory"
complete -c ccd -n "__fish_not_contain_opt -s h -s s -s i -s o" -s o -l opt -d "move under opt directory"
