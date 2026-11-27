{pkgs, ...}: let
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  notify = "${pkgs.libnotify}/bin/notify-send";

  batteryHypr = pkgs.writeShellScriptBin "battery-hypr" ''
    set -u

    STATE="battery"
    for supply in /sys/class/power_supply/*; do
      if [ "$(cat "$supply/type" 2>/dev/null)" = "Mains" ] && [ "$(cat "$supply/online" 2>/dev/null)" = "1" ]; then
        STATE="ac"
      fi
    done

    STATE_FILE="''${XDG_RUNTIME_DIR:-/tmp}/battery-hypr-state"
    if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "$STATE" ]; then
      exit 0
    fi
    echo "$STATE" > "$STATE_FILE"

    if [ "$STATE" = "battery" ]; then
      ${hyprctl} keyword monitor "eDP-1,1920x1080@60,auto,1"
      ${hyprctl} keyword animations:enabled 0
      ${hyprctl} keyword decoration:blur:enabled false
      ${notify} -a power -t 4000 "🔋 Battery mode" "60 Hz · animations off · blur off"
    else
      ${hyprctl} keyword monitor "eDP-1,1920x1080@144,auto,1"
      ${hyprctl} keyword animations:enabled 1
      ${hyprctl} keyword decoration:blur:enabled true
      ${notify} -a power -t 4000 "🔌 AC mode" "144 Hz · animations on · blur on"
    fi
  '';
in {
  home.packages = with pkgs; [
    upower
    libnotify
    batteryHypr
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${batteryHypr}/bin/battery-hypr"
  ];

  systemd.user.services.battery-hypr = {
    Unit.Description = "Apply Hyprland battery/AC settings";

    Service = {
      Type = "oneshot";
      ExecStart = "${batteryHypr}/bin/battery-hypr";
    };
  };
}
