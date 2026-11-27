{...}: let
  p = import ./palette.nix;
in {
  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };

  programs.fzf.colors = {
    bg = "-1";
    "bg+" = p.surface;
    fg = p.text;
    "fg+" = p.text;
    hl = p.accent;
    "hl+" = p.accentLight;
    info = p.subtext;
    prompt = p.accent;
    pointer = p.accent;
    marker = p.success;
    spinner = p.accentLight;
    header = p.subtext;
    border = p.overlay;
  };

  programs.lazygit = {
    enable = true;
    settings.gui.theme = {
      activeBorderColor = [p.accent "bold"];
      inactiveBorderColor = [p.surfaceBright];
      searchingActiveBorderColor = [p.warning "bold"];
      optionsTextColor = [p.accentLight];
      selectedLineBgColor = [p.surface];
      inactiveViewSelectedLineBgColor = [p.overlay];
      cherryPickedCommitFgColor = [p.bg];
      cherryPickedCommitBgColor = [p.magenta];
      markedBaseCommitFgColor = [p.bg];
      markedBaseCommitBgColor = [p.warning];
      unstagedChangesColor = [p.critical];
      defaultFgColor = [p.text];
    };
  };
}
