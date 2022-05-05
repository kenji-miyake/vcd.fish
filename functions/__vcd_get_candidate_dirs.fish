function __vcd_get_candidate_dirs
    # Get workspace directory
    set -l workspace_dir (__vcd_get_workspace_dir) || return 1

    # repos mode
    if [ "$VCD_MODE" = repos ]
        for f in (fd -I -t f -e repos --max-depth 1 . $workspace_dir)
            set candidate_dirs $candidate_dirs $VCSTOOL_SRC_DIR/(cat $f | grep -v "repositories" | sed -E "s/^  //g" | grep -v " .*" | grep -v "^\$" | sed -E "s/://g")
        end
    end

    # workspace mode
    if [ "$VCD_MODE" = code-workspace ]
        for f in (fd -I -t f -e code-workspace --max-depth 1 . $workspace_dir)
            set candidate_dirs $candidate_dirs (cat $f | jq --raw-output '.settings."git.scanRepositories"[]')
        end
    end

    # gitmodules mode
    if [ "$VCD_MODE" = gitmodules ]
        set candidate_dirs $candidate_dirs (cat $workspace_dir/.gitmodules | grep -oP "path = \K(.*)")
    end

    # Validate
    test "$candidate_dirs" = "" && return 1

    # Check existence
    for d in $candidate_dirs
        test -d $workspace_dir/$d && set valid_candidate_dirs $valid_candidate_dirs $d
    end

    # Remove src prefix
    set valid_candidate_dirs (printf "%s\n" $valid_candidate_dirs | sed -E "s|^$VCSTOOL_SRC_DIR/||g")

    # Remove duplicates
    set valid_candidate_dirs (printf "%s\n" $valid_candidate_dirs | awk '!x[$0]++')

    # Output
    printf "%s\n" $valid_candidate_dirs

    return 0
end
