function __ccd_find_package_dir
    set -l package_name $argv[1]
    set -l base_dir $argv[2]

    # Set default base directory if empty
    test "$base_dir" = "" && set -l base_dir $CCD_DEFAULT_MODE

    # Get workspace directory
    set -l workspace_dir (__vcd_get_workspace_dir) || return 1

    # Check search directory
    test -d "$workspace_dir/$base_dir" || return 1

    # Find candidate directories
    set -l candidate_dirs (fd -I -t f -t l --full-path "/$package_name/package.xml\$" $workspace_dir/$base_dir | xargs -I {} dirname {})

    # Validate
    test "$candidate_dirs" = "" && return 1

    # Output
    printf "%s\n" $candidate_dirs[1]

    return 0
end
