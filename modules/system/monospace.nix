{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
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
        monospace = ["JetBrainsMono Nerd Font"];
        sansSerif = ["JetBrainsMono Nerd Font"];
        serif = ["JetBrainsMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };

      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <match target="pattern">
            <edit name="family" mode="prepend" binding="strong">
              <string>JetBrainsMono Nerd Font</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
