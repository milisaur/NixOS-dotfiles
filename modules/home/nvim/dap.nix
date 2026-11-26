{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-go.enable = true;
    };

    extraPackages = [pkgs.delve];

    extraConfigLua = ''
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<F5>";
        action.__raw = "function() require('dap').continue() end";
        options.desc = "Debug: Start/Weiter";
      }
      {
        mode = "n";
        key = "<F10>";
        action.__raw = "function() require('dap').step_over() end";
        options.desc = "Debug: Überspringen";
      }
      {
        mode = "n";
        key = "<F11>";
        action.__raw = "function() require('dap').step_into() end";
        options.desc = "Debug: Hinein";
      }
      {
        mode = "n";
        key = "<F12>";
        action.__raw = "function() require('dap').step_out() end";
        options.desc = "Debug: Heraus";
      }
      {
        mode = "n";
        key = "<leader>db";
        action.__raw = "function() require('dap').toggle_breakpoint() end";
        options.desc = "Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dB";
        action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Bedingung: ')) end";
        options.desc = "Bedingter Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "function() require('dap').continue() end";
        options.desc = "Start/Weiter";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action.__raw = "function() require('dap').run_last() end";
        options.desc = "Letzte Sitzung";
      }
      {
        mode = "n";
        key = "<leader>dt";
        action.__raw = "function() require('dap').terminate() end";
        options.desc = "Beenden";
      }
      {
        mode = "n";
        key = "<leader>du";
        action.__raw = "function() require('dapui').toggle() end";
        options.desc = "Debug-Oberfläche";
      }
      {
        mode = ["n" "v"];
        key = "<leader>de";
        action.__raw = "function() require('dapui').eval() end";
        options.desc = "Ausdruck auswerten";
      }
    ];
  };
}
