function vcd
    # Help
    function __help -d "show help"
        printf "usage: vcd [-h] directory\n\n"

        printf "positional arguments:\n"
        printf "  repository_name     repository to move\n"
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
    set -l workspace_dir (__vcd_get_workspace_dir)
    if not test -d "$workspace_dir"
        printf "[vcd] failed to get workspace directory\n"
        return 1
    end

    # Set target directory
    # If repository_name is empty, move to workspace root
    set -l repository_name $argv[1]
    if [ "$repository_name" = "" ]
        set target_dir $workspace_dir
    else
        set target_dir $workspace_dir/$VCSTOOL_SRC_DIR/$repository_name
    end

    # Validate
    if not test -d "$target_dir"
        printf "[vcd] no such directory: $target_dir\n"
        return 1
    end

    # Change directory and refresh
    cd $target_dir
    commandline -f repaint
    return 0
end
