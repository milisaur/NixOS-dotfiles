{pkgs, ...}: let
  p = import ../home/palette.nix;
in {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.${p.fontPackage}
      nerd-fonts.iosevka-term
      nerd-fonts.monaspace
      nerd-fonts.commit-mono
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-cove
      nerd-fonts.blex-mono
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [p.font];
        sansSerif = [p.font];
        serif = [p.font];
        emoji = ["Noto Color Emoji"];
      };

      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <match target="pattern">
            <edit name="family" mode="prepend" binding="strong">
              <string>${p.font}</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
