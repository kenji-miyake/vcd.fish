function __vcd_get_workspace_dir
    # Find workspace
    set workspace_dir (__vcd_find_workspace_dir)

    # Use COLCON_PREFIX_PATH
    if not test -d "$workspace_dir" && set -q COLCON_PREFIX_PATH
        set workspace_dir (echo "$COLCON_PREFIX_PATH[1]" | sed -E "s/\/$VCSTOOL_INSTALL_DIR\$//g")
    end

    # Use CMAKE_PREFIX_PATH
    if not test -d "$workspace_dir" && set -q CMAKE_PREFIX_PATH
        if not string match -q "/opt/ros/*" "$CMAKE_PREFIX_PATH[1]"
            set workspace_dir (echo "$CMAKE_PREFIX_PATH[1]" | sed -E "s/\/($VCSTOOL_INSTALL_DIR)\/*.*\$//g")
        end
    end

    # Validate
    test -d "$workspace_dir" || return 1

    # Output
    printf "%s\n" $workspace_dir

    return 0
end
