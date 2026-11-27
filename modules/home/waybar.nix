{pkgs, ...}: let
  p = import ./palette.nix;
  generationScript = pkgs.writeShellApplication {
    name = "waybar-generation";
    runtimeInputs = [pkgs.coreutils];
    text = builtins.readFile ./waybar/generation.sh;
  };
  dashboardScript = pkgs.writeShellApplication {
    name = "waybar-dashboard";
    runtimeInputs = with pkgs; [
      coreutils
      procps
      systemd
      rofi
    ];
    text = builtins.readFile ./waybar/dashboard.sh;
  };
in {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/nixos-generation"
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
        };

        clock = {
          format = "󱑆  {:%H:%M}";
          tooltip-format = "{:%A, %d.%m.%Y %H:%M}";
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  Ethernet";
          format-disconnected = "󰖪  Offline";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "nm-applet";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟  muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        cpu = {
          format = "󰍛  {usage}%";
        };

        memory = {
          format = "󰘚  {}%";
        };

        battery = {
          format = "󰁹  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰂄  {capacity}%";
          format-warning = "󰁺  {capacity}%";
        };

        "custom/nixos-generation" = {
          exec = "${generationScript}/bin/waybar-generation";
          return-type = "json";
          interval = 300;
          tooltip = true;

          on-click-release = "${dashboardScript}/bin/waybar-dashboard";
          exec-on-event = false;
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: alpha(${p.bg}, 0.88);
        color: ${p.text};
        margin: 6px 10px;
      }

      #workspaces {
        margin: 6px 8px;
      }

      #workspaces button {
        padding: 0 12px;
        margin: 0 5px;
        background: transparent;
        color: ${p.subtext};
        border-radius: 10px;
      }

      #workspaces button.active {
        background: alpha(${p.accent}, 0.22);
        color: ${p.accentLight};
      }

      #workspaces button:hover {
        background: alpha(${p.accent}, 0.10);
        color: ${p.text};
      }

      #clock,
      #network,
      #pulseaudio,
      #custom-nixos-generation,
      #cpu,
      #memory,
      #battery,
      #tray {
        margin: 6px 6px;
        padding: 0 16px;
        border-radius: 10px;
        background: alpha(${p.surface}, 0.9);
      }

      #clock {
        font-weight: 600;
        color: ${p.accent};
      }

      #battery.warning {
        color: ${p.warning};
      }

      #battery.critical {
        color: ${p.critical};
      }

      #battery.charging {
        color: ${p.success};
      }

      tooltip {
        background: alpha(${p.surface}, 0.95);
        color: ${p.text};
        border: 1px solid ${p.accent};
        border-radius: 8px;
        padding: 8px;
      }
    '';
  };
}
