{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = false;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    settings = {
      theme = "Builtin Solarized Dark";

      font-family = "Iosevka";
      font-size = 21;
      adjust-cell-height = "102%";

      window-save-state = "always";
      window-step-resize = true;
      gtk-tabs-location = "hidden";

      keybind = "super+ctrl+f=toggle_fullscreen";

      mouse-hide-while-typing = true;

      cursor-style = "block";
      cursor-style-blink = false;

      shell-integration = "detect";
      clipboard-read = "allow";
      clipboard-write = "allow";

      macos-titlebar-style = "hidden";

      bell-features = "no-audio";
    };
  };
}
