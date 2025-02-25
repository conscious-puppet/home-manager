{ inputs, pkgs, ... }:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.copyq}/bin/copyq --start-server &
  '';
  # ${pkgs.swww}/bin/swww & # for wallpaper
  # sleep 1
  # ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
in
{

  programs.kitty.enable = true; # required for the default Hyprland config

  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland

    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      exec-once = ''
        ${startupScript}/bin/start
      '';
      input = {
        follow_mouse = 2;
      };
      "$mod" = "SUPER";
      binds = {
        allow_workspace_cycles = false;
      };
      bind =
        [
          "$mod SHIFT, L, exit,"
          "$mod SHIFT, T, exec, wezterm"
          "$mod, Tab, cyclenext," # change focus to another window
          "$mod, Tab, bringactivetotop," # bring it to the top
          "$mod, left, workspace, -1"
          "$mod, right, workspace, +1"
          "$mod SHIFT, left, movetoworkspace, -1"
          "$mod SHIFT, right, movetoworkspace, +1"
          "$mod CONTROL, H, movefocus, l"
          "$mod CONTROL, J, movefocus, d"
          "$mod CONTROL, K, movefocus, u"
          "$mod CONTROL, L, movefocus, r"
          "$mod CONTROL, C, killactive,"
          "$mod CONTROL, F, fullscreen,"
          "$mod, Space, exec, ${pkgs.rofi}/bin/rofi -show drun -show-icons"
          "$mod CONTROL SHIFT, 3, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
          "$mod CONTROL SHIFT, 4, exec, ${pkgs.hyprshot}/bin/hyprshot -m window"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList
            (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };

  };


  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.sessionVariables.HYPRSHOT_DIR = "/home/abhishek/Pictures/Screenshots/";

}
