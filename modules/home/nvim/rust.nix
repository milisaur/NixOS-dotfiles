{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      crates.enable = true;

      rustaceanvim = {
        enable = true;
        settings.server.default_settings.rust-analyzer = {
          check.command = "clippy";
          cargo.allFeatures = true;
          inlayHints.closureReturnTypeHints.enable = "with_block";
        };
      };
    };

    extraPackages = with pkgs; [
      rust-analyzer
    ];
  };
}
