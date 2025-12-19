# https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
# dconf dump / > old-conf.txt
{ config, inputs, pkgs, ... }: {
  dconf.settings = {
    # "org/gnome/shell/extensions/hidetopbar" = {
    #   enable-active-window = false;
    #   enable-intellihide = false;
    # };
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
      #   activate-window-menu = "disabled";
      #   toggle-message-tray = "disabled";
      #   close = [ "<Super>q" ];
      #   maximize = "disabled";
      #   minimize = [ "<Super>comma" ];
      #   move-to-monitor-down = "disabled";
      #   move-to-monitor-left = "disabled";
      #   move-to-monitor-right = "disabled";
      #   move-to-monitor-up = "disabled";
      #   move-to-workspace-down = "disabled";
      #   move-to-workspace-up = "disabled";
      #   toggle-maximized = [ "<Super>m" ]';
      #   unmaximize = "disabled";
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
      num-workspaces = 10;
    };
    # "org/gnome/shell/extensions/pop-shell" = {
    #   focus-right = "disabled";
    #   tile-by-default = true;
    #   tile-enter = "disabled";
    # };
    # "org/gnome/desktop/peripherals/touchpad" = {
    #   tap-to-click = true;
    #   two-finger-scrolling-enabled = true;
    # };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      next = [ "<Shift><Control>n" ];
      previous = [ "<Shift><Control>p" ];
      play = [ "<Shift><Control>space" ];
      custom-keybindings = [
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   name = "kitty super";
    #   command = "kitty -e tmux";
    #   binding = "<Super>Return";
    # };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    #   name = "kitty ctrl_alt";
    #   command = "kitty -e tmux";
    #   binding = "<Ctrl><Alt>t";
    # };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    #   name = "rofi-rbw";
    #   command = "rofi-rbw --action copy";
    #   binding = "<Ctrl><Super>s";
    # };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
    #   name = "rofi launcher";
    #   command = "rofi -theme nord -show run -display-run 'run: '";
    #   binding = "<Super>space";
    # };

    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
    #   name = "Terminal-Specific";
    #   application = {
    #     only = [ "gnome-terminal" "kgx" "Alacritty" "foot" ]; # Add your terminal name
    #   };
    #   remap = {
    #     "Super-c" = "C-S-c"; # Sends Ctrl+Shift+C (Copy)
    #     "Super-v" = "C-S-v"; # Sends Ctrl+Shift+V (Paste)
    #   };
    # };
  };
}
