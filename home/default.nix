# Edit this to install packages and modify dotfile configuration in your
# $HOME.
#
# https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
{ pkgs, inputs, ... }: {
  imports = [
    ./neovim
    ./vscode
    # ./emacs
    ./zsh.nix
    ./wezterm.nix
    ./tmux.nix
    ./helix.nix
    ./zellij.nix
    ./emacs.nix
  ];

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages =
    let
      darwinPackages =
        if pkgs.system == "aarch64-darwin" || pkgs.system == "x86_64-darwin" then
          with pkgs; [ raycast ]
        else
          [ ];
      linuxPackages =
        if pkgs.system == "aarch64-linux" || pkgs.system == "x86_64-linux" then
          with pkgs; [ ]
        else
          [ ];
    in
    with pkgs;
    [
      # fonts
      iosevka
      (nerdfonts.override { fonts = [ "Iosevka" ]; })

      lite-xl
      neovide
      rustup
      qemu
      lldb
      btop
      nix-output-monitor # https://github.com/maralorn/nix-output-monitor
      nix-info
      cachix
      lazygit # Better git UI
      git-lfs # Git extension for versioning large files
      tmate
      fzf
      fd # need for fzf
      # lapce
      # meld
      graphviz
      watch
      gnuplot
      toipe # terminal typing
      ngrok
      mdcat # cat for markdown
      slides # markdown presentation tool
      # tetex # latex tools, failing with the new repo
      tailscale # similar to ngrok
      ncdu # Disk usage analyzer
      nix
      obsidian # note taking app
      asciinema # asciinema is a suite of tools for recording, replaying, and sharing terminal sessions.
    ] ++ darwinPackages ++ linuxPackages;

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs; # https://yusef.napora.org/blog/pinning-nixpkgs-flake/
    gc.automatic = true;
  };

  # required to autoload fonts from packages installed via Home Manager
  fonts.fontconfig.enable = true;

  # Programs natively supported by home-manager.
  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=$HOME/.nix-profile/bin:/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    # https://haskell.flake.page/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship.enable = true;

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
  };
}
