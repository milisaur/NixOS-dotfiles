{
  pkgs,
  mars-mips,
  asm-simulator,
  hades,
  ...
}: {
  home.packages = with pkgs; [
    git
    git-crypt
    gnupg
    nano
    wev

    gh
    bind
    usbutils
    parted

    yazi

    gnome-keyring
    seahorse

    libnotify

    curl
    wget
    unzip

    file
    jq
    zoxide
    ffmpeg
    poppler
    imagemagick
    ueberzugpp
    imv

    ripgrep
    fd
    fzf
    bat
    btop
    lazygit

    texliveFull
    texstudio

    go
    gopls
    gotools
    golangci-lint

    python3
    pyright

    nodejs_24

    jdk25
    asm-simulator
    hades
    mars-mips

    alejandra

    playerctl
    brightnessctl

    anki

    steam-run

    maven
    tree

    zip

    wrangler
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
