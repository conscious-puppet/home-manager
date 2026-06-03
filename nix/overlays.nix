{ inputs, system, ... }: [
  (final: prev: {
    # wezterm = inputs.nixpkgs-24-05.legacyPackages.${system}.wezterm;
    zathura = inputs.nixpkgs-stable.legacyPackages.${system}.zathura;
    iosevka = inputs.nixpkgs-stable.legacyPackages.${system}.iosevka;
    nerd-fonts = prev.nerd-fonts // {
      iosevka = inputs.nixpkgs-stable.legacyPackages.${system}.nerd-fonts.iosevka;
    };

    vimPlugins = prev.vimPlugins // {
      nvim-calltree = prev.vimUtils.buildVimPlugin {
        name = "calltree";
        src = inputs.nvim-calltree;
      };
      neophyte-nvim = prev.vimUtils.buildVimPlugin {
        name = "neophyte";
        src = inputs.neophyte-nvim;
      };
    };
  })
]
