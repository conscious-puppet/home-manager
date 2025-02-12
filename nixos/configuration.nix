# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, system, config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };



  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboard
        # extraConfig = builtins.readFile /home/deftdawg/source/meta-mac/keyd/kde-mac-keyboard.conf; # use includes when debugging, easier to edit in vscode
        extraConfig = ''
          # Make Apple keyboards work the same way on KDE as they do on MacOS
          [main]
          # Bind both "Cmd" keys to trigger the 'meta_mac' layer
          leftmeta = layer(meta_mac)
          rightmeta = layer(meta_mac)

          # By default meta_mac = Ctrl+<key>, except for mappings below
          [meta_mac:C]
          # Use alternate Copy/Cut/Paste bindings from Windows that won't conflict with Ctrl+C used to break terminal apps
          # Copy (works everywhere (incl. vscode term) except Konsole)
          c = C-insert

          # Paste
          v = S-insert
          # Cut
          x = S-delete

          # FIXME: for Konsole, we must create a shortcut in our default Konsole profile to bind Copy's Alternate to 'Ctrl+Ins'
          # Switch directly to an open tab (e.g., Firefox, VS Code)
          1 = A-1
          2 = A-2
          3 = A-3
          4 = A-4
          5 = A-5
          6 = A-6
          7 = A-7
          8 = A-8
          9 = A-9

          # Move cursor to the beginning of the line
          left = home
          # Move cursor to the end of the line
          right = end

          # As soon as 'tab' is pressed (but not yet released), switch to the 'app_switch_state' overlay
          tab = swapm(app_switch_state, A-tab)

          [app_switch_state:A]
          # Being in this state holds 'Alt' down allowing us to switch back and forth with tab or arrow presses
        '';
      };
    };
  };







  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.abhishek = {
    isNormalUser = true;
    description = "abhishek";
    home = "/home/abhishek";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../nix/overlays.nix { inherit inputs system; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];
  environment.variables.EDITOR = "vim";


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
