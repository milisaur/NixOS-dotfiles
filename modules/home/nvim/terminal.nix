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
  };
}
