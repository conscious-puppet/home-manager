# https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
# dconf dump / > old-conf.txt

# TODOs:
# Cmd-left, right: to move to the windows
# update the fullscreen behaviour to move the full screen window to a new window

{ config, inputs, pkgs, ... }: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      # font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Nordic";
      toolkit-accessibility = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Control><Super>f" ];
      switch-windows = [ "<Super>Tab" ];
      close = [ "<Super>q" ];
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
      num-workspaces = 10;
    };
  };
}
