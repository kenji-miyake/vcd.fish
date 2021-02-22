function __ccd_get_base_dir --argument-names ccd_mode
    # Get base directory
    if test "$ccd_mode" = "src" || test "$ccd_mode" = "install"
        set workspace_dir (__vcd_get_workspace_dir)
        set base_dir $workspace_dir/$ccd_mode
    else if test "$ccd_mode" = "opt"
        set base_dir (__ccd_get_opt_dir)
    else
        return 1
    end

    # Validate
    test -d "$base_dir" || return 1

    # Output
    printf "%s\n" $base_dir

    return 0
end
