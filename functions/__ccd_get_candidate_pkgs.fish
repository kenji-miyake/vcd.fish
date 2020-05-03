function __ccd_get_candidate_pkgs
    set -l base_dir $argv[1]

    # Set default base directory if empty
    test "$base_dir" = "" && set -l base_dir $CCD_DEFAULT_MODE

    # Get workspace directory
    set -l workspace_dir (__vcd_get_workspace_dir) || return 1

    # Check search directory
    test -d "$workspace_dir/$base_dir" || return 1

    # Find candidate packages
    set -l candidate_pkgs (fd -I -t f -t l --full-path "/package.xml\$" $workspace_dir/$base_dir | xargs -I {} dirname {} | xargs -I {} basename {})

    # Validate
    test "$candidate_pkgs" = "" && return 1

    # Output
    printf "%s\n" $candidate_pkgs | awk '!x[$0]++'

    return 0
end
