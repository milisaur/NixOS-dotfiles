{...}: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
    ];
    monitor = [
      ",preferred,auto,1"
    ];

    input = {
      kb_layout = "de";
      kb_variant = "neo_qwertz";
      follow_mouse = 1;
      touchpad = {
        natural_scroll = false;
      };
    };
  };
}
