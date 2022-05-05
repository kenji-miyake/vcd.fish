function __vcd_get_candidate_dirs
    # Get workspace directory
    set -l workspace_dir (__vcd_get_workspace_dir) || return 1

    # repos mode
    if [ "$VCD_MODE" = repos ]
        for f in (fd -I -t f -e repos --max-depth 1 . $workspace_dir)
            set candidate_dirs $candidate_dirs (cat $f | grep -v "repositories" | sed -E "s/^  //g" | grep -v " .*" | grep -v "^\$" | sed -E "s/://g")
        end
    end

    # workspace mode
    if [ "$VCD_MODE" = code-workspace ]
        for f in (fd -I -t f -e code-workspace --max-depth 1 . $workspace_dir)
            set candidate_dirs $candidate_dirs (cat $f | jq --raw-output '.settings."git.scanRepositories"[]' | sed -E "s/^$VCSTOOL_SRC_DIR\///g")
        end
    end
    end

    # Validate
    test "$candidate_dirs" = "" && return 1

    # Output
    printf "%s\n" $candidate_dirs | awk '!x[$0]++'

    return 0
end
