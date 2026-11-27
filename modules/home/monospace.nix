{pkgs, ...}: let
  p = import ./palette.nix;
in {
  gtk.font = {
    name = p.font;
    size = 10;
    package = pkgs.nerd-fonts.${p.fontPackage};
  };

  dconf.settings."org/gnome/desktop/interface" = {
    font-name = "${p.font} 10";
    document-font-name = "${p.font} 10";
    monospace-font-name = "${p.font} 10";
  };

  programs.zathura.options.font = "${p.font} 10";

  wayland.windowManager.hyprland.settings.group.groupbar.font_family = p.font;
}
