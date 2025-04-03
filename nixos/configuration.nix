{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # edit as per your location and timezone
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
      LC_CTYPE = "en_US.utf8"; # required by dmenu don't change this
    };
  };

  # sound.enable = true;

  # services = {
  # xserver = {
  #   layout = "us";
  #   xkbVariant = "";
  #   enable = true;
  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       i3status
  #     ];
  #   };
  #   desktopManager = {
  #     xterm.enable = false;
  #     xfce = {
  #       enable = true;
  #       noDesktop = true;
  #       enableXfwm = false;
  #     };
  #   };
  #   displayManager = {
  #     lightdm.enable = true;
  #     defaultSession = "xfce+i3";
  #   };
  # };
  # };

  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
      Macs = [
        "hmac-sha1"
        "hmac-sha1-96"
        "hmac-sha2-256"
        "hmac-sha2-512"
        "hmac-md5"
        "hmac-md5-96"
        "hmac-md5-etm@openssh.com"
        "hmac-md5-96-etm@openssh.com"
        "hmac-sha1-etm@openssh.com"
        "hmac-sha1-96-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "hmac-sha2-512-etm@openssh.com"
        "umac-64-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
    };
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  users.users = {
    abhishek = {
      isNormalUser = true;
      description = "abhishek";
      home = "/home/abhishek";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
    };
  };

  # password-less sudo
  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    wezterm
    dmenu
    git
    gnome.gnome-keyring
    nerdfonts
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    rofi
    vim
    unrar
    unzip
    firefox
    xclip
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
