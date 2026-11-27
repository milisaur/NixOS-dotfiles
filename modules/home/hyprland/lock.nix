{
  config,
  pkgs,
  lib,
  hostName,
  ...
}: let
  p = import ../palette.nix;
  hex = lib.removePrefix "#";
  extension =
    if hostName == "ankylosaurus"
    then "jpg"
    else "png";
  wallpaper = "${config.home.homeDirectory}/.dotfiles/assets/wallpapers/${hostName}/lock.${extension}";
in {
  home.packages = with pkgs; [
    hyprlock
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ${wallpaper}
      blur_passes = 3
      blur_size = 10
    }

    label {
      monitor =
      text = $TIME
      font_size = 60
      color = rgba(255,255,255,1)
      position = 0, 120
      halign = center
      valign = center
    }

    input-field {
      monitor =
      size = 300, 55
      outline_thickness = 2

      outer_color = rgb(${hex p.accent})
      inner_color = rgba(${hex p.bg}cc)
      font_color = rgb(${hex p.text})
      check_color = rgb(${hex p.accentLight})
      fail_color = rgb(${hex p.critical})

      placeholder_text = <i>Password</i>
      fade_on_empty = false

      position = 0, -40
      halign = center
      valign = center
    }
  '';
}
