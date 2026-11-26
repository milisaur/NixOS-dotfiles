{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      crates.enable = true;

      rustaceanvim = {
        enable = true;

        settings = {
          server.default_settings.rust-analyzer = {
            check.command = "clippy";
            cargo.allFeatures = true;
            inlayHints.closureReturnTypeHints.enable = "with_block";
          };

          dap.autoload_configurations = true;
        };
      };
    };

    extraPackages = with pkgs; [
      rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];
  };
}
