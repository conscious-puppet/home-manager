{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nvim-calltree.url = "github:conscious-puppet/calltree.nvim";
    nvim-calltree.flake = false;

    neophyte-nvim.url = "github:tim-harding/neophyte";
    neophyte-nvim.flake = false;

    # Emacs
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "nixpkgs";

    # Dev tools
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      imports = [
        inputs.treefmt-nix.flakeModule
      ];


      perSystem = { self', inputs', pkgs, system, config, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system; config.allowUnfree = true;
            overlays = [
              (final: prev: {
                wezterm = inputs.nixpkgs-24-05.legacyPackages.${system}.wezterm;
                vimPlugins = prev.vimPlugins // {
                  nvim-calltree = prev.vimUtils.buildVimPlugin {
                    name = "calltree";
                    src = inputs.nvim-calltree;
                  };
                  neophyte-nvim = prev.vimUtils.buildVimPlugin {
                    name = "neophyte";
                    src = inputs.neophyte-nvim;
                  };
                  trouble-nvim = inputs.nixpkgs-24-05.legacyPackages.${system}.vimPlugins.trouble-nvim;
                };
              })
            ];
          };

          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              nixpkgs-fmt.enable = true;
              stylua.enable = true;
            };
          };


          legacyPackages.homeConfigurations.abhisheksingh = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home
              inputs.nix-doom-emacs-unstraightened.hmModule
              {
                home = {
                  username = "abhisheksingh";
                  homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/abhisheksingh";
                  stateVersion = "22.11";
                };
              }
            ];
            extraSpecialArgs = { inherit inputs; };
          };

          legacyPackages.homeConfigurations.abhishek = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home
              inputs.nix-doom-emacs-unstraightened.hmModule
              {
                home = {
                  username = "abhishek";
                  homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/abhishek";
                  stateVersion = "22.11";
                };
              }
            ];
            extraSpecialArgs = { inherit inputs; };
          };

          # Enables 'nix run' to activate.
          apps.default.program = pkgs.writeShellScriptBin "activate-home" ''
            ${inputs'.home-manager.packages.default}/bin/home-manager switch
          '';

          devShells.default = pkgs.mkShell {

            inputsFrom = [
              config.treefmt.build.devShell
            ];

            packages = with pkgs; [
              inputs'.home-manager.packages.default
              just
              nixd # Nix language server
            ];
          };
        };
    };
}
