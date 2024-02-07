{ self, inputs, config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    userSettings = import ./settings {};
  };

  # home.sessionVariables.NVIM_JDT_LANGUAGE_SERVER = "${pkgs.jdt-language-server}/bin/jdt-language-server";
  # home.sessionVariables.NVIM_LOMBOK_JAR = "${pkgs.lombok}/share/java/lombok.jar";

  # home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/home/neovim/config";
  # home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./config;
}

