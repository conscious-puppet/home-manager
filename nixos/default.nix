# /run/wrappers/bin/sudo nixos-rebuild switch --flake .#nixos
{ inputs, ... }: {
  nixosConfigurations.nixos = let system = "x86_64-linux"; in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      extraArgs = {
        inherit inputs system;
      };
      modules = [
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
        }
        inputs.nixos-cosmic.nixosModules.default
        ./configuration.nix
        ./cosmic.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            users.abhishek = {
              imports = [
                ../home/common
                ../home/nixos
              ];
              home.username = "abhishek";
              home.homeDirectory = "/home/abhishek";
              home.stateVersion = "24.11";
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
}
