{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.callPackage ../../../pkgs/lumo.nix {})
  ];

  services.gnome.gnome-keyring.enable = true;
}
