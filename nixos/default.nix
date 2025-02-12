# /run/wrappers/bin/sudo nixos-rebuild switch --flake .#nixos
{ inputs, ... }: {
  nixosConfigurations.nixos = let system = "x86_64-linux"; in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      extraArgs = {
        inherit inputs system;
      };
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            users.abhishek = {
              imports = [ ../home ];
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
