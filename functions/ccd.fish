function ccd
    # Help
    function __help -d "show help"
        printf "usage: ccd [-h] directory\n\n"

        printf "positional arguments:\n"
        printf "  package_directory   package directory to move\n"
        printf "\n"

        printf "optional arguments:\n"
        printf "  -h, --help          show this help message and exit\n"
        printf "  -s, --src           move under src directory\n"
        printf "  -i, --install       move under install directory\n"
        printf "\n"

        return 0
    end

    # Parse arguments
    set -l options "h/help" "s/src" "i/install"
    argparse -x "s,i" $options -- $argv || return 1

    # Show help
    set -q _flag_help && __help && return 0

    # Set base directory
    set -l base_dir $CCD_DEFAULT_MODE
    set -q _flag_src && set base_dir $VCSTOOL_SRC_DIR
    set -q _flag_install && set base_dir install

    # Get workspace directory
    if not set -l workspace_dir (__vcd_get_workspace_dir)
        printf "[ccd] failed to get workspace directory\n"
        return 1
    end

    # Check search directory
    test -d "$workspace_dir/$base_dir" || return 1

    # Find package directory
    set -l package_name $argv[1]
    if [ "$package_name" = "" ]
        set package_directory $workspace_dir
    else
        set package_directory (__ccd_find_package_dir $package_name $base_dir)
    end

    # Validate
    if [ "$package_directory" = "" ]
        printf "[ccd] no such package: $package_name\n"
        return 1
    else if not test -d "$package_directory"
        printf "[ccd] no such directory: $package_directory\n"
        return 1
    end

    # Change directory and refresh
    cd $package_directory
    commandline -f repaint
    return 0
end
