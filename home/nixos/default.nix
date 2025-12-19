{ config, inputs, pkgs, ... }: {
  imports = [ ];
  home.packages = with pkgs; [ slack lsof ];
}
