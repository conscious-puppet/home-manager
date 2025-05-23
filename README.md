# Home Manager Configuration

This repository contains configurations for managing your development and system environment using Nix and Home Manager.

## Features

- **Nix Flakes**: Declarative system configuration with `flake.nix`.
- **Home Manager**: Manage user-level configurations for tools like Neovim, Emacs, Zsh, and more.
- **Doom Emacs**: Custom configurations for Doom Emacs.
- **i3 Window Manager**: Configurations for the i3 window manager.
- **NixOS**: System-level configurations for NixOS.

## Directory Structure

- `home/`: User-level configurations for various tools.
- `nixos/`: System-level configurations for NixOS.
- `doom.d/`: Doom Emacs configurations.
- `i3/`: i3 window manager configurations.
- `nix/`: Nix overlays and additional configurations.

## Getting Started

1. Install [Nix](https://nixos.org/download.html).
2. Clone this repository:
   ```bash
   git clone <repository-url>
   cd home-manager
   ```
3. Use Home Manager to apply configurations:
   ```bash
   nix run .#homeConfigurations.<username>.activationPackage
   ```

## Contributing

Feel free to submit issues or pull requests to improve this repository.

## License

This project is licensed under the MIT License.