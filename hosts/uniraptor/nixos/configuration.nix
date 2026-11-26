{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../../modules/system/common.nix
    ../../../modules/system/desktop.nix
    ../../../modules/system/android.nix
  ];

  networking.hostName = "uniraptor";

  environment.systemPackages = with pkgs; [
    kitty
    rofi
    hyprpaper
    mako
    neovim
  ];
}
