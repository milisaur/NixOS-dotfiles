{config, ...}: {
  programs.nixvim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
