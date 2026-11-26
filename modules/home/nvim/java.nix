{
  lib,
  pkgs,
  ...
}: let
  jdtls = pkgs.jdt-language-server;
  javaDebug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
  javaTest = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
in {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.nvim-jdtls];

    lsp.servers.jdtls = {
      enable = true;
      package = jdtls;

      config = {
        capabilities.__raw = "require('cmp_nvim_lsp').default_capabilities()";

        cmd.__raw = ''
          function(dispatchers, config)
            local root = config.root_dir or vim.fn.getcwd()
            local name = vim.fn.fnamemodify(root, ':t') .. '-' .. vim.fn.sha256(root):sub(1, 8)
            local data = vim.fs.joinpath(vim.fn.stdpath('cache'), 'jdtls', name)
            return vim.lsp.rpc.start(
              { '${lib.getExe jdtls}', '--jvm-arg=-Xmx2G', '-data', data },
              dispatchers,
              { cwd = config.cmd_cwd or root, env = config.cmd_env }
            )
          end
        '';

        settings.java = {
          configuration = {
            updateBuildConfiguration = "interactive";
            runtimes = [
              {
                name = "JavaSE-1.8";
                path = "${pkgs.jdk8.home}";
              }
              {
                name = "JavaSE-17";
                path = "${pkgs.jdk17.home}";
              }
              {
                name = "JavaSE-21";
                path = "${pkgs.jdk21.home}";
              }
              {
                name = "JavaSE-25";
                path = "${pkgs.jdk25.home}";
                default = true;
              }
            ];
          };
          eclipse.downloadSources = true;
          maven.downloadSources = true;
          signatureHelp.enabled = true;
          contentProvider.preferred = "fernflower";
          inlayHints.parameterNames.enabled = "all";
          sources.organizeImports = {
            starThreshold = 9999;
            staticStarThreshold = 9999;
          };
          completion.favoriteStaticMembers = [
            "org.junit.jupiter.api.Assertions.*"
            "org.junit.Assert.*"
            "org.hamcrest.Matchers.*"
            "org.mockito.Mockito.*"
            "java.util.Objects.requireNonNull"
          ];
          codeGeneration.useBlocks = true;
        };

        init_options = {
          extendedClientCapabilities.__raw = "require('jdtls').extendedClientCapabilities";
          bundles.__raw = ''
            (function()
              local bundles = vim.fn.glob('${javaDebug}/com.microsoft.java.debug.plugin-*.jar', true, true)
              for _, jar in ipairs(vim.fn.glob('${javaTest}/*.jar', true, true)) do
                local name = vim.fn.fnamemodify(jar, ':t')
                if name ~= 'com.microsoft.java.test.runner-jar-with-dependencies.jar' and name ~= 'jacocoagent.jar' then
                  table.insert(bundles, jar)
                end
              end
              return bundles
            end)()
          '';
        };
      };
    };

    extraPackages = [pkgs.maven];

    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["java"];
        callback.__raw = ''
          function()
            vim.bo.shiftwidth = 4
            vim.bo.tabstop = 4
          end
        '';
      }
      {
        event = ["LspAttach"];
        callback.__raw = ''
          function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client or client.name ~= 'jdtls' then
              return
            end

            local jdtls = require('jdtls')
            require('jdtls.setup').add_commands()
            jdtls.setup_dap({ hotcodereplace = 'auto' })
            require('jdtls.dap').setup_dap_main_class_configs()

            local function map(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
            end

            map('n', '<leader>jo', jdtls.organize_imports, 'Imports ordnen')
            map('n', '<leader>jv', jdtls.extract_variable, 'Variable extrahieren')
            map('v', '<leader>jv', function() jdtls.extract_variable(true) end, 'Variable extrahieren')
            map('n', '<leader>jc', jdtls.extract_constant, 'Konstante extrahieren')
            map('v', '<leader>jc', function() jdtls.extract_constant(true) end, 'Konstante extrahieren')
            map('v', '<leader>jm', function() jdtls.extract_method(true) end, 'Methode extrahieren')
            map('n', '<leader>jt', jdtls.test_nearest_method, 'Test (Methode)')
            map('n', '<leader>jT', jdtls.test_class, 'Test (Klasse)')
            map('n', '<leader>jg', require('jdtls.tests').generate, 'Tests generieren')
            map('n', '<leader>js', require('jdtls.tests').goto_subjects, 'Test/Klasse wechseln')
            map('n', '<leader>ju', jdtls.update_project_config, 'Projekt neu laden')
            map('n', '<leader>jr', '<cmd>TermExec cmd="java %:p" direction=horizontal<CR>', 'Datei ausführen')
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>mc";
        action = "<cmd>TermExec cmd=\"mvn -q compile\" direction=horizontal<CR>";
        options.desc = "compile";
      }
      {
        mode = "n";
        key = "<leader>mt";
        action = "<cmd>TermExec cmd=\"mvn test\" direction=horizontal<CR>";
        options.desc = "test";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>TermExec cmd=\"mvn package\" direction=horizontal<CR>";
        options.desc = "package";
      }
      {
        mode = "n";
        key = "<leader>mC";
        action = "<cmd>TermExec cmd=\"mvn clean\" direction=horizontal<CR>";
        options.desc = "clean";
      }
    ];
  };
}
