# NixOS-dotfiles

A declarative NixOS configuration for multiple machines, built with flakes and Home Manager.

The repository contains both the system and the user configuration. Host-specific settings are kept separate from shared modules, so each machine only selects the parts it needs.

## Project Status

The configuration is in daily use on three machines and changes frequently. It is tailored to my hardware and is not intended to work on other systems without adjustments.

## Machines

| Host | Purpose |
|---|---|
| `ankylosaurus` | Gaming desktop |
| `spinosaurus` | University and development laptop |
| `uniraptor` | University and development desktop |

## Features

- Flake-based configuration with pinned inputs.
- Home Manager integrated as a NixOS module, so one rebuild applies system and user configuration.
- Shared modules that each host imports individually.
- Hyprland on Wayland with Waybar, Rofi, Kitty and Mako.
- Neovim configured through Nixvim, including LSP, completion and debugging.
- A single colour palette used by all themed programs.
- Laptop power management with separate AC and battery behaviour.
- Local LLM setup on the laptop using Ollama and Open WebUI.
- Custom packages for MARS, HADES, ASM-Simulator and Lumo.

## Installation

### Requirements

- NixOS with flakes enabled
- Git

Flakes are enabled in `configuration.nix`:

```nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```

### Setup

Clone the repository:

```bash
git clone git@github.com:milisaur/NixOS-dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

The repository has to be located at `~/.dotfiles`, because the wallpaper and lock screen modules refer to that path.

To add a machine, copy an existing folder in `hosts/`, replace `hardware-configuration.nix`, change the hostname in `configuration.nix` and add the host to `flake.nix`.

Build and activate the configuration:

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

## Usage

Stage the changes and rebuild:

```bash
git add .
sudo nixos-rebuild switch --flake .#<hostname>
```

Commit once the rebuild has succeeded:

```bash
git commit -m "message"
git push
```

New files have to be staged before the rebuild, as flakes only include tracked files.

Format the Nix files:

```bash
nix fmt
```

## Project Structure

```text
NixOS-dotfiles/
├── assets/
├── hosts/
│   ├── ankylosaurus/
│   ├── spinosaurus/
│   └── uniraptor/
├── modules/
│   ├── home/
│   └── system/
├── pkgs/
├── flake.nix
├── flake.lock
├── README.md
└── LICENSE
```

| Path | Purpose |
|---|---|
| `flake.nix` | Entry point, defines the inputs and one configuration per host |
| `hosts/<hostname>/nixos/` | System configuration and hardware configuration of a machine |
| `hosts/<hostname>/home-manager/` | User configuration of a machine |
| `modules/system/` | Shared NixOS modules |
| `modules/home/` | Shared Home Manager modules |
| `pkgs/` | Custom packages |
| `assets/` | Files used by the custom packages, and the wallpapers |

## Theming

Colours, font, gaps and border radii are defined once in `modules/home/palette.nix`. The themed modules import this file, so a changed value is applied everywhere after the next rebuild.

Wallpapers are not tracked. They are expected in `assets/wallpapers/<hostname>/`, with the lock screen image named `lock.png` (`lock.jpg` on `ankylosaurus`).

## Known Limitations

- The configuration is not plug-and-play.
- Several modules contain hardware-specific values, such as PCI bus IDs and monitor layouts.
- The repository path `~/.dotfiles` is hard-coded in two modules.
- Some modules are still experimental.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
