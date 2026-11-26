{pkgs, ...}: {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
      float.border = "rounded";
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        gopls = {
          enable = true;
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true;
                compositeLiteralFields = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };
          };
        };

        pyright.enable = true;
        nil_ls.enable = true;
        bashls.enable = true;
        lemminx.enable = true;

        r_language_server = {
          enable = true;
          package = null;
          extraOptions = {
            settings = {
              r.lsp.diagnostics = false;
            };
          };
        };
      };
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          go = ["goimports" "gofmt"];
          python = ["black"];
          r = ["styler"];
          nix = ["alejandra"];
        };
        format_on_save.__raw = ''
          function(bufnr)
            if vim.g.autoformat_off or vim.b[bufnr].autoformat_off then
              return
            end
            return { timeout_ms = 2000, lsp_format = "fallback" }
          end
        '';
      };
    };

    extraPackages = with pkgs; [
      black
      alejandra
      gotools
      rPackages.styler
    ];

    extraConfigLua = ''
      vim.keymap.set('n', '<leader>uf', function()
        vim.g.autoformat_off = not vim.g.autoformat_off
        vim.notify('Formatieren beim Speichern: ' .. (vim.g.autoformat_off and 'aus' or 'an'))
      end, { desc = 'Formatieren beim Speichern' })

      vim.keymap.set('n', '<leader>uh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
      end, { desc = 'Inlay Hints' })
    '';

    keymaps = [
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Telescope lsp_definitions<CR>";
        options.desc = "Definition";
      }
      {
        mode = "n";
        key = "gD";
        action.__raw = "vim.lsp.buf.declaration";
        options.desc = "Deklaration";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>Telescope lsp_implementations<CR>";
        options.desc = "Implementierungen";
      }
      {
        mode = "n";
        key = "gy";
        action = "<cmd>Telescope lsp_type_definitions<CR>";
        options.desc = "Typdefinition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        options = {
          desc = "Referenzen";
          nowait = true;
        };
      }
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Dokumentation";
      }
      {
        mode = "i";
        key = "<C-s>";
        action.__raw = "vim.lsp.buf.signature_help";
        options.desc = "Signatur";
      }
      {
        mode = ["n" "v"];
        key = "<leader>ca";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code-Aktion";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action.__raw = "vim.lsp.buf.rename";
        options.desc = "Umbenennen";
      }
      {
        mode = ["n" "v"];
        key = "<leader>cf";
        action.__raw = "function() require('conform').format({ async = true, lsp_format = 'fallback' }) end";
        options.desc = "Formatieren";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        options.desc = "Symbole (Datei)";
      }
      {
        mode = "n";
        key = "<leader>fS";
        action = "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>";
        options.desc = "Symbole (Projekt)";
      }
      {
        mode = "n";
        key = "[d";
        action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
        options.desc = "Vorherige Diagnose";
      }
      {
        mode = "n";
        key = "]d";
        action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
        options.desc = "Nächste Diagnose";
      }
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "vim.diagnostic.open_float";
        options.desc = "Diagnose anzeigen";
      }
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "Alle Diagnosen";
      }
      {
        mode = "n";
        key = "<leader>xb";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        options.desc = "Diagnosen (Datei)";
      }
    ];
  };
}
