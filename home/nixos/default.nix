{ config, inputs, pkgs, ... }: {
  imports = [
    # ./hyprland.nix
  ];

  home.packages = with pkgs; [ slack lsof ];
  home.file."./.config/i3/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/i3/i3config";
  home.file."./.config/i3status/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/i3/i3statusconfig";
}
