{config, ...}: {
  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

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
