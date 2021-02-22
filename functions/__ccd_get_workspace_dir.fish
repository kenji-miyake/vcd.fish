function __ccd_get_workspace_dir --argument-names ccd_mode
    # Get workspace directory
    if test "$ccd_mode" = "src" || test "$ccd_mode" = "install"
        set workspace_dir (__vcd_get_workspace_dir)
    else if test "$ccd_mode" = "opt"
        set workspace_dir (__ccd_get_opt_dir)
    else
        return 1
    end

    # Validate
    test -d "$workspace_dir" || return 1

    # Output
    printf "%s\n" $workspace_dir

    return 0
end
