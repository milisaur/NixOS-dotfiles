{
  pkgs,
  mars-mips,
  asm-simulator,
  hades,
  ...
}: {
  home.packages = with pkgs; [
    # Git
    git
    git-crypt
    gh
    lazygit

    # Security
    gnupg
    gnome-keyring
    seahorse

    # CLI tools
    bat
    btop
    fd
    file
    fzf
    jq
    nano
    ripgrep
    tree
    yazi
    zoxide

    # Network
    bind
    curl
    wget

    # System tools
    brightnessctl
    libnotify
    parted
    playerctl
    usbutils
    wev

    # Archives
    unzip
    zip

    # Media
    ffmpeg
    imagemagick
    imv
    poppler
    ueberzugpp

    # Nix
    alejandra

    # Rust
    rustc
    cargo
    rustfmt
    clippy

    # Go
    go
    gopls
    gotools
    golangci-lint

    # Python
    python3
    pyright

    # Java
    jdk25
    maven

    # Web development
    nodejs_24
    wrangler

    # Computer science
    asm-simulator
    hades
    mars-mips

    # Studying and writing
    anki
    texliveFull
    texstudio

    # Compatibility
    steam-run
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
