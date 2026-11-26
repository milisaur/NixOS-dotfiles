{pkgs, ...}: {
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunderbird.enable = true;

  programs.zsh.enable = true;
  users.users.mili.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    waybar
    wl-clipboard
    grim
    slurp
  ];
}
