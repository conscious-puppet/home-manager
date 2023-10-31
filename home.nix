# Edit this to install packages and modify dotfile configuration in your
# $HOME.
#
# https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
{ pkgs, inputs, ... }: {
  imports = [
    # This loads ./home/neovim/default.nix - neovim configured for Haskell dev, and other things.
    ./home/neovim
    # Add more of your home-manager modules here.
    ./home/zsh.nix
    ./home/wezterm.nix
    ./home/tmux.nix
  ];

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages =
    let
      darwinPackages = if pkgs.system == "aarch64-darwin" || pkgs.system == "x86_64-darwin" then with pkgs; [ raycast ] else [ ];
      linuxPackages = if pkgs.system == "aarch64-linux" || pkgs.system == "x86_64-linux" then with pkgs; [ ] else [ ];
    in
    with pkgs; [
      rustup
      qemu
      lldb
      btop
      nix-output-monitor # https://github.com/maralorn/nix-output-monitor
      nix-info
      cachix
      lazygit # Better git UI
      tmate
      fzf
      fd # need for fzf
      emacs
      # lapce
      # meld
      graphviz
      watch
      gnuplot
      toipe
      ngrok
      mdcat # cat for markdown
    ] ++ darwinPackages ++ linuxPackages;

  # Programs natively supported by home-manager.
  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
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
