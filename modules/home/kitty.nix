{pkgs, ...}: let
  p = import ./palette.nix;
in {
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 10;
      enable_audio_bell = false;
      confirm_os_window_close = 0;

      window_padding_width = 8;

      background_opacity = 0.95;

      scrollback_lines = 10000;

      foreground = p.text;
      background = p.bg;
      cursor = p.accent;
      cursor_text_color = p.bg;
      selection_foreground = p.bg;
      selection_background = p.accentDark;
      url_color = p.accentLight;
      active_border_color = p.accent;
      inactive_border_color = p.overlay;
      active_tab_foreground = p.bg;
      active_tab_background = p.accent;
      inactive_tab_foreground = p.subtext;
      inactive_tab_background = p.surface;

      color0 = p.surface;
      color8 = "#4a3a3f";
      color1 = p.critical;
      color9 = "#ff8078";
      color2 = p.success;
      color10 = "#c3d082";
      color3 = p.warning;
      color11 = "#ffc870";
      color4 = "#7daea3";
      color12 = "#9cc4ba";
      color5 = "#d3869b";
      color13 = "#e2a3b4";
      color6 = "#89b482";
      color14 = "#a6cba0";
      color7 = p.text;
      color15 = "#fff4ea";
    };
  };
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
