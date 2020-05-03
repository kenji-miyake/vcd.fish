function vcd
    # Help
    function __help -d "show help"
        printf "usage: vcd [-h] directory\n\n"

        printf "positional arguments:\n"
        printf "  directory           directory to move\n"
        printf "\n"

        printf "optional arguments:\n"
        printf "  -h, --help          show this help message and exit\n"
        printf "\n"

        return 0
    end

    # Parse arguments
    set -l options "h/help"
    argparse $options -- $argv || return 1

    # Show help
    set -q _flag_help && __help && return 0

    # Get workspace directory
    if not set -l workspace_dir (__vcd_get_workspace_dir)
        printf "[vcd] failed to get workspace directory\n"
        return 1
    end

    # Set directory
    set -l repository_name $argv[1]
    if [ "$repository_name" = "" ]
        set directory $workspace_dir
    else
        set directory $workspace_dir/$VCSTOOL_SRC_DIR/$repository_name
    end

    # Validate
    if not test -d "$directory"
        printf "[vcd] no such directory: $directory\n"
        return 1
    end

    # Change directory and refresh
    cd $directory
    commandline -f repaint
    return 0
end
