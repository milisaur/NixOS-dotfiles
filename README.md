# Personal NixOS configuration using **flakes** with **Home Manager**, built for a multi-machine setup.

---

## Overview

This repository contains my system and user configuration for multiple NixOS machines.  
It separates host-specific configuration from shared components while keeping the setup simple and maintainable.

---

This setup is built around:

- **NixOS + flakes**
- **Home Manager**
- **Modular configuration**
- **Multi-host support**

Each machine has its own configuration while sharing common modules where appropriate.

---

## Structure
```text
├── assets
│   ├── wallpapers/        (not tracked, see Notes)
│   ├── ASM-Simulator.jar
│   └── Hades_Editor_und_Simulator.jar
├── flake.lock
├── flake.nix
├── hosts
│   ├── ankylosaurus
│   │   ├── home-manager/
│   │   └── nixos/
│   ├── spinosaurus
│   │   ├── home-manager/
│   │   └── nixos/
│   └── uniraptor
│       ├── home-manager/
│       └── nixos/
├── modules
│   ├── home
│   │   ├── hyprland/
│   │   ├── joplin/
│   │   ├── rofi/
│   │   ├── waybar/
│   │   ├── yazi/
│   │   ├── zettlr/
│   │   └── *.nix
│   └── system
│       ├── llm/
│       ├── common.nix
│       ├── desktop.nix
│       ├── workstation.nix
│       └── *.nix
├── pkgs
│   ├── asm-simulator.nix
│   ├── hades.nix
│   └── mars-mips.nix
├── LICENSE
└── README.md
```

## Layout

- **hosts/** – machine-specific NixOS and Home Manager configurations  
- **modules/system/** – shared NixOS modules  
- **modules/home/** – shared Home Manager modules  
- **pkgs/** – custom packages (MARS, ASM-Simulator, HADES)  
- **flake.nix** – entry point for building systems 

---

### Hosts

Each host defines:
- hardware configuration
- system-specific settings
- imported shared modules

### Modules

Reusable configs for:
- desktop environments
- programs
- services
- shared system logic

### Home

User-level configuration managed via Home Manager.

---

## Machines

| Host          | Purpose                          |
|---------------|----------------------------------|
| ankylosaurus  | Gaming desktop                   |
| spinosaurus   | University / development laptop  |
| uniraptor     | University / development desktop |


---

## Features

- NixOS with flake-based configuration  
- Home Manager integration  
- Multi-host setup  
- Wayland environment (Hyprland)  
- Waybar, Rofi, Kitty, Mako  
- Development + gaming environments

---

## Caveats

- Not plug-and-play
- Hardware-specific configs exist
- Some modules are still experimental

---

## Installation

Requirements:
- NixOS with flakes enabled in ` configuration.nix ` [nix.settings.experimental-features = ["nix-command" "flakes"];]
- Git
- Internet connection

Clone the repository:

```bash
git clone git@github.com:milisaur/NixOS-dotfiles.git ~/.dotfiles
cd ~/.dotfiles/
```

Usage:

- Change hostname in ` configuration.nix` + `flake.nix`
- Adjust hardware config per machine
- Modify modules in `modules/`

Rebuild system:

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

---

## Workflow 

```bash
git pull
# make changes
git add .
git commit -m "message"
git push

sudo nixos-rebuild switch --flake .#<hostname>
```

---

## Notes

- hardware-configuration.nix is specific to each machine
- This setup is tailored to my hardware and may require adjustments on other systems
- Shared modules are gradually being introduced
- Wallpapers are not tracked; put them in `assets/wallpapers/<hostname>/` (lock screen: `lock.png`, `lock.jpg` on ankylosaurus)
- Format with `nix fmt`

---

## License

MIT, see [LICENSE](LICENSE).
