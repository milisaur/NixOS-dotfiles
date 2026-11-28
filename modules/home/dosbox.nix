{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.dosbox-staging];

  home.file."dos/.keep".text = "";

  xdg.configFile."dosbox/dosbox-staging.conf".text = ''
    [dos]
    keyboard_layout = gr

    [autoexec]
    mount c ${config.home.homeDirectory}/dos
    c:
  '';
}
