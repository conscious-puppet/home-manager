# WIP
{ self, inputs, config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    userSettings = import ./settings {};
  };
}

