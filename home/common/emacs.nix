{ pkgs, lib, ... }: {
  # https://docs.doomemacs.org/v21.12/modules/lang/org/#/prerequisites/nixos
  home.packages = [
    pkgs.texlive.combined.scheme-full
  ];

  programs.doom-emacs = {
    enable = true;
    # emacs = pkgs.emacs29-pgtk;
    doomDir = ../../doom.d;
    experimentalFetchTree = true; # Disable if there are fetcher issues
    extraPackages = epkgs: with epkgs; [
      treesit-grammars.with-all-grammars
      vterm
      exec-path-from-shell
      all-the-icons
      nerd-icons
    ];
  };
}
