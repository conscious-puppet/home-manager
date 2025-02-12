{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];

      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      flake = {
        imports = [
          ./nixos
          {
            _module.args = { inherit inputs; };
          }
        ];
      };

      perSystem = { self', inputs', pkgs, system, config, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system; config.allowUnfree = true;
            overlays = import ./nix/overlays.nix { inherit inputs system; };
          };

          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              nixpkgs-fmt.enable = true;
              stylua.enable = true;
            };
          };

          # for macos (only home-manager)
          legacyPackages.homeConfigurations.abhisheksingh =
            inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home/common
                ./home/macos
                inputs.nix-doom-emacs-unstraightened.hmModule
                {
                  home = {
                    username = "abhisheksingh";
                    homeDirectory = "/Users/abhisheksingh";
                    stateVersion = "24.11";
                  };
                }
              ];
              extraSpecialArgs = { inherit inputs; };
            };

          # Enables 'nix run' to activate home-manager.
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
