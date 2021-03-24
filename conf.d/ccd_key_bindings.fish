function __ccd_fzf
    if not set -l workspace_dir (__vcd_get_workspace_dir)
        printf "[ccd] failed to get workspace directory\n"
        return 1
    end

    if not set -l candidate_pkgs (__ccd_get_candidate_pkgs (__ccd_get_base_dir $CCD_DEFAULT_MODE))
        printf "[ccd] no candidate found: mode = $CCD_DEFAULT_MODE\n"
        return 1
    end

    set -l package_name (printf "%s\n" $candidate_pkgs | fzf --query (commandline -b)) || return 1
    ccd $package_name
end

if not set -q CCD_DISABLE_KEYBINDINGS
    bind \e\cv '__ccd_fzf'
    bind -M insert \e\cv '__ccd_fzf'
end
