function __ccd_get_candidate_pkgs --argument-names base_dir
    # Check search directory
    test -d "$base_dir" || return 1

    # Find candidate packages
    set -l candidate_pkgs (fd -I -t f -t l --full-path "/package.xml\$" $base_dir | xargs -I {} dirname {} | xargs -I {} basename {})

    # Validate
    test "$candidate_pkgs" = "" && return 1

    # Output
    printf "%s\n" $candidate_pkgs | awk '!x[$0]++'

    return 0
end
