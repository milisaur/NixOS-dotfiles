{pkgs, ...}: {
  gtk.font = {
    name = "JetBrainsMono Nerd Font";
    size = 10;
    package = pkgs.nerd-fonts.jetbrains-mono;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    font-name = "JetBrainsMono Nerd Font 10";
    document-font-name = "JetBrainsMono Nerd Font 10";
    monospace-font-name = "JetBrainsMono Nerd Font 10";
  };

  programs.zathura.options.font = "JetBrainsMono Nerd Font 10";

  wayland.windowManager.hyprland.settings.group.groupbar.font_family = "JetBrainsMono Nerd Font";
}
