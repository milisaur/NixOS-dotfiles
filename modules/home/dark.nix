{pkgs, ...}: let
  p = import ./palette.nix;

  qtRow = colors: builtins.concatStringsSep ", " colors;

  qtPalette = pkgs.writeText "qt-palette.conf" ''
    [ColorScheme]
    active_colors=${qtRow [p.text p.surface p.surfaceBright p.overlay p.bg p.overlay p.text p.textBright p.text p.surface p.bg "#000000" p.accent p.bg p.accent p.accentDark p.overlay p.bg p.surface p.text p.subtextDim]}
    inactive_colors=${qtRow [p.text p.surface p.surfaceBright p.overlay p.bg p.overlay p.text p.textBright p.text p.surface p.bg "#000000" p.accentDark p.bg p.accent p.accentDark p.overlay p.bg p.surface p.text p.subtextDim]}
    disabled_colors=${qtRow [p.muted p.surface p.surfaceBright p.overlay p.bg p.overlay p.muted p.subtext p.muted p.surface p.bg "#000000" p.overlay p.subtextDim p.muted p.muted p.overlay p.bg p.surface p.subtextDim p.mutedDark]}
  '';

  qtct = {
    Appearance = {
      style = "Fusion";
      custom_palette = true;
      color_scheme_path = "${qtPalette}";
      icon_theme = "Papirus-Dark";
      standard_dialogs = "xdgdesktopportal";
    };
    Fonts = {
      general = ''"${p.font},11"'';
      fixed = ''"${p.font},11"'';
    };
  };

  colors = ''
    @define-color accent_color ${p.accent};
    @define-color accent_bg_color ${p.accent};
    @define-color accent_fg_color ${p.bg};
    @define-color destructive_color ${p.critical};
    @define-color destructive_bg_color ${p.critical};
    @define-color destructive_fg_color ${p.bg};
    @define-color success_color ${p.success};
    @define-color success_bg_color ${p.success};
    @define-color success_fg_color ${p.bg};
    @define-color warning_color ${p.warning};
    @define-color warning_bg_color ${p.warning};
    @define-color warning_fg_color ${p.bg};
    @define-color error_color ${p.critical};
    @define-color error_bg_color ${p.critical};
    @define-color error_fg_color ${p.bg};
    @define-color window_bg_color ${p.bg};
    @define-color window_fg_color ${p.text};
    @define-color view_bg_color ${p.surface};
    @define-color view_fg_color ${p.text};
    @define-color headerbar_bg_color ${p.bg};
    @define-color headerbar_fg_color ${p.text};
    @define-color headerbar_border_color ${p.overlay};
    @define-color headerbar_backdrop_color ${p.bg};
    @define-color sidebar_bg_color ${p.surface};
    @define-color sidebar_fg_color ${p.text};
    @define-color sidebar_backdrop_color ${p.surface};
    @define-color card_bg_color ${p.surface};
    @define-color card_fg_color ${p.text};
    @define-color dialog_bg_color ${p.surface};
    @define-color dialog_fg_color ${p.text};
    @define-color popover_bg_color ${p.surface};
    @define-color popover_fg_color ${p.text};
    @define-color theme_bg_color ${p.bg};
    @define-color theme_fg_color ${p.text};
    @define-color theme_base_color ${p.surface};
    @define-color theme_text_color ${p.text};
    @define-color theme_selected_bg_color ${p.accent};
    @define-color theme_selected_fg_color ${p.bg};
    @define-color theme_unfocused_selected_bg_color ${p.accentDark};
    @define-color theme_unfocused_selected_fg_color ${p.bg};
    @define-color borders ${p.overlay};
    @define-color unfocused_borders ${p.overlay};
  '';

  vars = ''
    :root {
      --accent-color: ${p.accent};
      --accent-bg-color: ${p.accent};
      --accent-fg-color: ${p.bg};
      --destructive-bg-color: ${p.critical};
      --destructive-fg-color: ${p.bg};
      --success-bg-color: ${p.success};
      --success-fg-color: ${p.bg};
      --warning-bg-color: ${p.warning};
      --warning-fg-color: ${p.bg};
      --error-bg-color: ${p.critical};
      --error-fg-color: ${p.bg};
      --window-bg-color: ${p.bg};
      --window-fg-color: ${p.text};
      --view-bg-color: ${p.surface};
      --view-fg-color: ${p.text};
      --headerbar-bg-color: ${p.bg};
      --headerbar-fg-color: ${p.text};
      --sidebar-bg-color: ${p.surface};
      --sidebar-fg-color: ${p.text};
      --card-bg-color: ${p.surface};
      --card-fg-color: ${p.text};
      --dialog-bg-color: ${p.surface};
      --dialog-fg-color: ${p.text};
      --popover-bg-color: ${p.surface};
      --popover-fg-color: ${p.text};
    }
  '';
in {
  dconf = {
    enable = true;

    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
      accent-color = "orange";
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "orange";};
    };

    gtk3.extraCss = colors;

    # GTK4 verwendet die dunkle Farbpräferenz.
    # Erzwinge kein GTK4-Theme für libadwaita.
    gtk4.theme = null;
    gtk4.extraCss = colors + vars;
  };

  xdg.dataFile."themes/adw-gtk3-dark".source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark";

  xdg.configFile."systemd/user/xdg-desktop-portal-gtk.service.d/theme.conf".text = ''
    [Service]
    Environment=GTK_THEME=adw-gtk3-dark
  '';

  wayland.windowManager.hyprland.settings.env = [
    "GTK_THEME,adw-gtk3-dark"
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    qt5ctSettings = qtct;
    qt6ctSettings = qtct;
  };
}
