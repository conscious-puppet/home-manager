{ self, inputs, config, pkgs, lib, ... }: {
  programs.helix = {
    enable = true;
    settings = { theme = "kanagawa"; };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
  };
}
