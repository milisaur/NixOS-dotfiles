{pkgs, ...}: {
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["mili"];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  services.dbus.enable = true;
  services.resolved.enable = true;
  services.gnome.gnome-keyring.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gparted
    vulkan-tools
  ];
}
