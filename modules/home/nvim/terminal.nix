{config, ...}: {
  home.sessionVariables.MANPAGER = "nvim +Man!";
  programs.kitty = {
    settings = {
      allow_remote_control = "socket-only";
      listen_on = "unix:\${XDG_RUNTIME_DIR}/kitty";
      shell_integration = "enabled";
    };
    extraConfig = ''
      action_alias kitty_scrollback_nvim kitten ${config.programs.nixvim.plugins.kitty-scrollback.package}/python/kitty_scrollback_nvim.py
      map kitty_mod+h kitty_scrollback_nvim
      map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
    '';
  };
  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.loaded_netrwPlugin = 1;

    plugins.yazi = {
      enable = true;
      settings.open_for_directories = true;
    };

    plugins.kitty-scrollback.enable = true;

    keymaps = [
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Terminal-Modus verlassen";
      }
      {
        mode = "t";
        key = "<C-h>";
        action = "<cmd>wincmd h<CR>";
      }
      {
        mode = "t";
        key = "<C-j>";
        action = "<cmd>wincmd j<CR>";
      }
      {
        mode = "t";
        key = "<C-k>";
        action = "<cmd>wincmd k<CR>";
      }
      {
        mode = "t";
        key = "<C-l>";
        action = "<cmd>wincmd l<CR>";
      }

      {
        mode = "n";
        key = "-";
        action = "<cmd>Yazi<CR>";
        options.desc = "Yazi (aktuelle Datei)";
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<cmd>Yazi cwd<CR>";
        options.desc = "Yazi (Arbeitsverzeichnis)";
      }
    ];

    autoCmd = [
      {
        event = ["TextYankPost"];
        callback.__raw = "function() vim.hl.on_yank() end";
      }
      {
        event = ["BufReadPost"];
        callback.__raw = ''
          function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end
        '';
      }
    ];
  };
}
