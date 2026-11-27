{pkgs, ...}: let
  p = import ./palette.nix;
in {
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 10;
      modify_font = "cell_height 140%";
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
      color8 = p.surfaceBright;
      color1 = p.critical;
      color9 = p.criticalBright;
      color2 = p.success;
      color10 = p.successBright;
      color3 = p.warning;
      color11 = p.warningBright;
      color4 = p.blue;
      color12 = p.blueBright;
      color5 = p.magenta;
      color13 = p.magentaBright;
      color6 = p.cyan;
      color14 = p.cyanBright;
      color7 = p.text;
      color15 = p.textBright;
    };
  };
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
