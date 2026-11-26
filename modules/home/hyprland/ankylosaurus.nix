{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,1920x1080@60,0x0,1"
      "DP-3,1920x1080@60,1920x0,1"
      "HDMI-A-1,1920x1080@60,3840x0,1"
      "DP-2,1680x1050@74.89,5760x0,1"
    ];

    #     "ckb-next -b"

    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:DP-3, default:true"
      "3, monitor:HDMI-A-1, default:true"
      "4, monitor:DP-2, default:true"
    ];

    input = {
      kb_layout = "de";
      kb_variant = "neo_qwertz";
      follow_mouse = 1;
    };
  };
}
