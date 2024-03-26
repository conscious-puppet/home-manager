# WIP
{ self, inputs, config, pkgs, lib, ... }: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      use-package

      evil
      evil-collection

      general # mostly for keybindings

      which-key

      toc-org
      org-bullets

      sudo-edit

      # completions
      ivy
      counsel
      ivy-rich

      # icons
      all-the-icons
      all-the-icons-dired
      all-the-icons-ivy-rich

      vterm
      vterm-toggle

      kanagawa-theme
      rainbow-mode
      # todo
      # dirvish # better dired: https://github.com/alexluigit/dirvish
      # nerd-icons # replacement for all the icons: https://github.com/rainstormstudio/nerd-icons.el
    ] ++ (with pkgs; [
      fd
    ]);
  };

  home.file.".config/home-manager/home/emacs/config/envs.el".source = import ./envs.nix { inherit pkgs lib config; };
  home.file."./.emacs.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/home/emacs/config";
}
