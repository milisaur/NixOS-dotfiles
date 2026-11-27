{...}: let
  p = import ../palette.nix;
in {
  programs.nixvim = {
    highlightOverride = {
      MatchParen = {
        bg = p.surfaceBright;
        fg = p.textBright;
        bold = true;
      };
      MatchWord.underline = true;
      TreesitterContext.bg = p.surface;
      TreesitterContextBottom = {
        underline = true;
        sp = p.overlay;
      };
    };

    plugins = {
      vim-matchup = {
        enable = true;
        settings = {
          matchparen_deferred = 1;
          matchparen_hi_surround_always = 1;
          matchparen_offscreen.method = "popup";
        };
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 3;
          multiline_threshold = 1;
        };
      };
    };
  };
}
