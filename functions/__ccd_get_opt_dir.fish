function __ccd_get_opt_dir
    # Check ROS_DISTRO
    set -q ROS_DISTRO || return 1

    # Set variable
    set -l opt_dir "/opt/ros/$ROS_DISTRO"

    # Validate
    test -d "$opt_dir" || return 1

    # Output
    printf "%s\n" $opt_dir

    return 0
end
