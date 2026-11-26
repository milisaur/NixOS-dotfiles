{pkgs, ...}: {
  programs.nixvim = {
    # Diagnostics
    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
      float.border = "rounded";
    };

    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;

        servers = {
          # Nix
          nil_ls.enable = true;

          # Go
          gopls = {
            enable = true;
            settings.gopls.hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              constantValues = true;
              functionTypeParameters = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };

          # Python
          pyright.enable = true;
          ruff.enable = true;

          # C / C++
          clangd.enable = true;

          # Lua
          lua_ls.enable = true;

          # Shell
          bashls.enable = true;

          # Web
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          emmet_ls.enable = true;

          # Configuration
          jsonls.enable = true;
          yamlls.enable = true;
          taplo.enable = true;
          lemminx.enable = true;

          # Markdown
          marksman.enable = true;

          # R
          r_language_server = {
            enable = true;
            package = null;
            extraOptions.settings.r.lsp.diagnostics = false;
          };
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;

        settings = {
          formatters_by_ft = {
            # Programming
            nix = ["alejandra"];
            go = ["goimports" "gofmt"];
            rust = ["rustfmt"];
            python = ["black"];
            c = ["clang-format"];
            cpp = ["clang-format"];
            lua = ["stylua"];
            r = ["styler"];

            # Shell
            sh = ["shfmt"];
            bash = ["shfmt"];

            # Web
            javascript = ["prettier"];
            javascriptreact = ["prettier"];
            typescript = ["prettier"];
            typescriptreact = ["prettier"];
            html = ["prettier"];
            css = ["prettier"];
            scss = ["prettier"];
            less = ["prettier"];

            # Configuration
            json = ["prettier"];
            jsonc = ["prettier"];
            yaml = ["prettier"];
            toml = ["taplo"];

            # Documentation
            markdown = ["prettier"];
          };

          format_on_save.__raw = ''
            function(bufnr)
              if vim.g.autoformat_off or vim.b[bufnr].autoformat_off then
                return
              end

              return {
                timeout_ms = 2000,
                lsp_format = "fallback"
              }
            end
          '';
        };
      };
    };

    # Formatters
    extraPackages = with pkgs; [
      alejandra
      black
      clang-tools
      gotools
      prettier
      rPackages.styler
      rustfmt
      shfmt
      stylua
      taplo
    ];

    keymaps = [
      # Navigation
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

      # Documentation
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

      # Code
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
        action.__raw = ''
          function()
            require('conform').format({
              async = true,
              lsp_format = 'fallback'
            })
          end
        '';
        options.desc = "Formatieren";
      }

      # Diagnostics
      {
        mode = "n";
        key = "[d";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = -1, float = true })
          end
        '';
        options.desc = "Vorherige Diagnose";
      }
      {
        mode = "n";
        key = "]d";
        action.__raw = ''
          function()
            vim.diagnostic.jump({ count = 1, float = true })
          end
        '';
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

      # Toggles
      {
        mode = "n";
        key = "<leader>uf";
        action.__raw = ''
          function()
            vim.g.autoformat_off = not vim.g.autoformat_off

            vim.notify(
              'Formatieren beim Speichern: ' ..
              (vim.g.autoformat_off and 'aus' or 'an')
            )
          end
        '';
        options.desc = "Formatieren beim Speichern";
      }
      {
        mode = "n";
        key = "<leader>uh";
        action.__raw = ''
          function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
              { bufnr = 0 }
            )
          end
        '';
        options.desc = "Inlay Hints";
      }
    ];
  };
}
