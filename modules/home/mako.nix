{...}: let
  p = import ./palette.nix;
in {
  services.mako = {
    enable = true;

    settings = {
      background-color = "${p.bg}dd";
      text-color = p.text;
      border-color = p.accent;

      border-size = 2;
      border-radius = 12;

      padding = "12";
      margin = "12";

      default-timeout = 5000;

      font = "${p.font} 11";

      icons = 1;
      max-icon-size = 32;
    };
  };
}
