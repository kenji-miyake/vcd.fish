function __ccd_find_package_dir --argument-names package_path base_dir
    # Split path
    set -l package_name (string replace -a -r -- "(\w+)\/.*" "\$1" "$package_path")

    if string match -q -r -- "\/" "$package_path"
        set package_subdir (string replace -a -r -- "\w+\/(.*)" "\$1" "$package_path")
    else
        set package_subdir ""
    end

    # Check search directory
    test -d "$base_dir" || return 1

    # Find candidate directories
    set -l candidate_dirs (fd -I -t f -t l --full-path "/$package_name/package.xml\$" $base_dir | xargs -I {} dirname {})

    # Check if found
    test "$candidate_dirs" = "" && return 1

    # Set target directory
    set package_dir $candidate_dirs[1]
    set target_dir (string replace -a -r -- "\/\$" "" $package_dir/$package_subdir)

    # Validate
    test -d "$target_dir" || return 1

    # Output
    printf "%s\n" $target_dir

    return 0
end
