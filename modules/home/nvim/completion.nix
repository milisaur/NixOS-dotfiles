{...}: {
  programs.nixvim.plugins = {
    luasnip.enable = true;

    friendly-snippets.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;
      autoLoad = true;

      settings = {
        completion = {
          completeopt = "menu,menuone,noinsert";
        };

        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require('luasnip')
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { 'i', 's' })
          '';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require('luasnip')
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' })
          '';
        };

        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
    };
  };
}
