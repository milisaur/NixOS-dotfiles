{pkgs, ...}: let
  p = import ./palette.nix;
in {
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      statusbar-home-tilde = true;

      default-bg = p.bg;
      default-fg = p.text;
      statusbar-bg = p.surface;
      statusbar-fg = p.text;
      inputbar-bg = p.surface;
      inputbar-fg = p.text;
      notification-bg = p.surface;
      notification-fg = p.text;
      notification-error-bg = p.surface;
      notification-error-fg = p.critical;
      notification-warning-bg = p.surface;
      notification-warning-fg = p.warning;
      completion-bg = p.surface;
      completion-fg = p.text;
      completion-highlight-bg = p.accentDark;
      completion-highlight-fg = p.bg;
      index-bg = p.bg;
      index-fg = p.text;
      index-active-bg = p.accentDark;
      index-active-fg = p.bg;
      highlight-color = p.warning;
      highlight-active-color = p.accent;
      recolor-lightcolor = p.bg;
      recolor-darkcolor = p.text;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["org.pwmt.zathura.desktop"];
  };
}
