{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../../modules/system/common.nix
    ../../../modules/system/desktop.nix
    ../../../modules/system/workstation.nix
    ../../../modules/system/android.nix
  ];

  networking.hostName = "ankylosaurus";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.murmur = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    home-manager
    hyprpaper
    hyprshot
    kitty
    libnotify
    lxqt.lxqt-policykit
    lutris
    mako
    prismlauncher
    protonup-qt
    simple-scan
    wine
  ];
}
