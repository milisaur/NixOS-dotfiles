{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/system/common.nix
    ../../../modules/system/desktop.nix
    ../../../modules/system/workstation.nix
    ../../../modules/system/power.nix
    ../../../modules/system/nvidia-prime.nix
    ../../../modules/system/laptop.nix
    ../../../modules/system/gigabyte-keyboard.nix
    ../../../modules/system/llm
    ../../../modules/system/monospace.nix
  ];

  networking.hostName = "spinosaurus";
}
