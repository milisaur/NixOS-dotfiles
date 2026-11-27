{
  pkgs,
  lib,
  ...
}: let
  lumo = pkgs.stdenv.mkDerivation rec {
    pname = "lumo-desktop";
    version = "0.5.10";

    src = pkgs.fetchurl {
      url = "https://proton.me/download/lumo/linux/0.5.10/Lumo_0.5.10_amd64.deb";
      hash = "sha256-6uYVEdwpii2c6zYRF5o3lUlqYtape1hwox1pUBFgYmI=";
    };

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      wrapGAppsHook3
    ];

    buildInputs = with pkgs; [
      webkitgtk_4_1
      gtk3
      libsoup_3
      glib
      glib-networking
      openssl
      dbus
      libayatana-appindicator
    ];

    runtimeDependencies = with pkgs; [
      libayatana-appindicator
    ];

    unpackPhase = ''
      dpkg-deb -x $src .
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r usr/bin usr/share $out/
      runHook postInstall
    '';

    meta = {
      description = "Lumo Desktop by Proton";
      homepage = "https://github.com/ProtonLumo/lumo-desktop";
      license = lib.licenses.gpl3Only;
      platforms = ["x86_64-linux"];
      mainProgram = "lumo-desktop";
    };
  };
in {
  environment.systemPackages = [lumo];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
