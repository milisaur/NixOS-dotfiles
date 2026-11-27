{...}: let
  p = import ../palette.nix;
in {
  xdg.configFile."yazi/yazi.toml".source = ./yazi.toml;

  xdg.configFile."yazi/theme.toml".text = ''
    [mgr]
    cwd = { fg = "${p.accent}", bold = true }
    find_keyword = { fg = "${p.warning}", bold = true, underline = true }
    find_position = { fg = "${p.accentLight}", bold = true }
    marker_copied = { fg = "${p.success}", bg = "${p.success}" }
    marker_cut = { fg = "${p.critical}", bg = "${p.critical}" }
    marker_marked = { fg = "${p.cyan}", bg = "${p.cyan}" }
    marker_selected = { fg = "${p.accent}", bg = "${p.accent}" }
    count_copied = { fg = "${p.bg}", bg = "${p.success}" }
    count_cut = { fg = "${p.bg}", bg = "${p.critical}" }
    count_selected = { fg = "${p.bg}", bg = "${p.accent}" }
    border_style = { fg = "${p.overlay}" }

    [indicator]
    current = { fg = "${p.bg}", bg = "${p.accent}", bold = true }
    parent = { fg = "${p.text}", bg = "${p.overlay}" }
    preview = { fg = "${p.text}", bg = "${p.overlay}" }

    [tabs]
    active = { fg = "${p.bg}", bg = "${p.accent}", bold = true }
    inactive = { fg = "${p.subtext}", bg = "${p.surface}" }

    [mode]
    normal_main = { fg = "${p.bg}", bg = "${p.accent}", bold = true }
    normal_alt = { fg = "${p.accent}", bg = "${p.surface}" }
    select_main = { fg = "${p.bg}", bg = "${p.magenta}", bold = true }
    select_alt = { fg = "${p.magenta}", bg = "${p.surface}" }
    unset_main = { fg = "${p.bg}", bg = "${p.critical}", bold = true }
    unset_alt = { fg = "${p.critical}", bg = "${p.surface}" }

    [status]
    perm_type = { fg = "${p.blue}" }
    perm_read = { fg = "${p.warning}" }
    perm_write = { fg = "${p.critical}" }
    perm_exec = { fg = "${p.success}" }
    perm_sep = { fg = "${p.surfaceBright}" }
    progress_label = { fg = "${p.text}", bold = true }
    progress_normal = { fg = "${p.accent}", bg = "${p.surface}" }
    progress_error = { fg = "${p.critical}", bg = "${p.surface}" }

    [input]
    border = { fg = "${p.accent}" }
    title = { fg = "${p.text}" }
    value = { fg = "${p.text}" }
    selected = { bg = "${p.overlay}" }

    [which]
    mask = { bg = "${p.surface}" }
    cand = { fg = "${p.accent}" }
    rest = { fg = "${p.subtext}" }
    desc = { fg = "${p.text}" }
    separator_style = { fg = "${p.surfaceBright}" }
  '';
}
