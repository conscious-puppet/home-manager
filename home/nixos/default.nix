{ config, inputs, pkgs, ... }: {
  imports = [ ./gnome-settings.nix ];
  home.packages = with pkgs; [ slack lsof ];
}
