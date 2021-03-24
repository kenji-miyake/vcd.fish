function ccd
    # Help
    function __help -d "show help"
        printf "usage: ccd [-h] directory\n\n"

        printf "positional arguments:\n"
        printf "  package_path        package to move\n"
        printf "\n"

        printf "optional arguments:\n"
        printf "  -h, --help          show this help message and exit\n"
        printf "  -s, --src           move under src directory\n"
        printf "  -i, --install       move under install directory\n"
        printf "  -o, --opt           move under opt directory\n"
        printf "\n"

        return 0
    end

    # Parse arguments
    set -l options "h/help" "s/src" "i/install" "o/opt"
    argparse -x "s,i,o" $options -- $argv || return 1

    # Show help
    set -q _flag_help && __help && return 0

    # Set base directory
    set -l ccd_mode $CCD_DEFAULT_MODE
    set -q _flag_src && set ccd_mode src
    set -q _flag_install && set ccd_mode install
    set -q _flag_opt && set ccd_mode opt

    # Set target directory
    set -l package_path $argv[1]
    if [ "$package_path" = "" ]
        # If package_path is empty, move to workspace root
        set target_dir (__ccd_get_workspace_dir $ccd_mode)
    else
        # Get base directory
        set -l base_dir (__ccd_get_base_dir $ccd_mode)
        if not test -d "$base_dir"
            printf "[ccd] failed to get base directory\n"
            return 1
        end

        # Find package path
        set target_dir (__ccd_find_package_dir $package_path $base_dir)
        if [ "$target_dir" = "" ]
            printf "[ccd] no such package path: $package_path\n"
            return 1
        end
    end

    # Validate
    if not test -d "$target_dir"
        printf "[ccd] no such directory: $target_dir\n"
        return 1
    end

    # Change directory and refresh
    cd $target_dir
    commandline -f repaint
    return 0
end
