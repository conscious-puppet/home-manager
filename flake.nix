{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";

    # Emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    nvim-calltree.url = "github:conscious-puppet/calltree.nvim";
    nvim-calltree.flake = false;
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      imports = [
        inputs.nixos-flake.flakeModule
      ];

      flake.homeModules.default = ./home.nix;

      flake.templates.default = {
        description = "A `home-manager` template providing useful tools & settings for Nix-based development";
        path = builtins.path {
          path = ./.;
          filter = path: _:
            !(inputs.nixpkgs.lib.hasSuffix "LICENSE" path ||
              inputs.nixpkgs.lib.hasSuffix "README.md" path);
        };
      };

      perSystem = { self', pkgs, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system; config.allowUnfree = true;
            overlays = [
              (final: prev: {
                vimPlugins = prev.vimPlugins // {
                  nvim-calltree = prev.vimUtils.buildVimPlugin {
                    name = "calltree";
                    src = inputs.nvim-calltree;
                  };
                };
              })
            ];
          };
          legacyPackages.homeConfigurations.abhisheksingh =
            self.nixos-flake.lib.mkHomeConfiguration
              pkgs
              ({ pkgs, ... }: {
                imports = [ self.homeModules.default ];
                home.username = "abhisheksingh";
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/abhisheksingh";
                home.stateVersion = "22.11";
              });

          legacyPackages.homeConfigurations.abhishek =
            self.nixos-flake.lib.mkHomeConfiguration
              pkgs
              ({ pkgs, ... }: {
                imports = [ self.homeModules.default ];
                home.username = "abhishek";
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/abhishek";
                home.stateVersion = "22.11";
              });

          legacyPackages.homeConfigurations."abhishek.singh1@identity.juspay.net" =
            self.nixos-flake.lib.mkHomeConfiguration
              pkgs
              ({ pkgs, ... }: {
                imports = [ self.homeModules.default ];
                home.username = "abhishek.singh1@identity.juspay.net";
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/abhisheksingh";
                home.stateVersion = "22.11";
              });

          # Enables 'nix run' to activate.
          apps.default.program = self'.packages.activate-home;
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [ neovim ];
          };

          # Enable 'nix build' to build the home configuration, but without
          # activating.
          # packages.default = self'.legacyPackages.homeConfigurations.${myUserName}.activationPackage;
          # packages.default = self'.legacyPackages.homeConfigurations.abhisheksingh.activationPackage;
        };
    };
}
