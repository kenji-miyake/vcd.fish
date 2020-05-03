function __vcd_fzf
    if not set -l workspace_dir (__vcd_get_workspace_dir)
        printf "[vcd] failed to get workspace directory\n"
        return 1
    end

    if not set -l candidate_dirs (__vcd_get_candidate_dirs)
        printf "[vcd] no candidate found: mode = $VCD_MODE\n"
        return 1
    end

    set -l repository_name (printf "%s\n" $candidate_dirs | fzf --query (commandline -b)) || return 1
    vcd $repository_name
end

if not set -q VCD_DISABLE_KEYBINDINGS
    bind \cv '__vcd_fzf'
    bind -M insert \cv '__vcd_fzf'
end
