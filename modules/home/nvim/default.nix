{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./lsp.nix
    ./completion.nix
    ./java.nix
    ./dap.nix
    ./rust.nix
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs.source = inputs.nixvim.inputs.nixpkgs;

    globals.mapleader = " ";

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";
        transparent_background = true;
        integrations = {
          treesitter = true;
          gitsigns = true;
          cmp = true;
          telescope.enabled = true;
          native_lsp.enabled = true;
          which_key = true;
          fidget = true;
          lsp_trouble = true;
          dap = true;
          dap_ui = true;
        };
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      cursorline = true;
      updatetime = 250;
      signcolumn = "yes";
      scrolloff = 8;
      splitright = true;
      splitbelow = true;
      undofile = true;
      timeoutlen = 400;
    };

    clipboard.register = "unnamedplus";

    plugins = {
      toggleterm = {
        enable = true;
        settings = {
          size = 50;
          direction = "vertical";
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_filetypes = {};
          shade_terminals = true;
          shading_factor = 2;
          start_in_insert = true;
          insert_mappings = true;
          persist_size = true;
          persist_mode = true;
          close_on_exit = true;
          shell = "${pkgs.zsh}/bin/zsh";
        };
      };

      lualine.enable = true;
      web-devicons.enable = true;
      telescope.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      fidget.enable = true;
      trouble.enable = true;

      which-key = {
        enable = true;
        settings.spec = [
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "Debug";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Suchen";
          }
          {
            __unkeyed-1 = "<leader>j";
            group = "Java";
          }
          {
            __unkeyed-1 = "<leader>m";
            group = "Maven";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "Umschalten";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnosen";
          }
        ];
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };

      quarto.enable = true;
      otter.enable = true;
    };

    extraConfigLua = ''
      vim.api.nvim_set_keymap('n', '<leader>t', ':vsplit | terminal<CR>', { noremap = true, silent = true })

      vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Fenster nach links' })
      vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Fenster nach unten' })
      vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Fenster nach oben' })
      vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Fenster nach rechts' })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Dateien";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Text";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffer";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "Hilfe";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<CR>";
        options.desc = "Tastenbelegung";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Speichern";
      }
    ];
  };
}
