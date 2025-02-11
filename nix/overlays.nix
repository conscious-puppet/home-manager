{ inputs, system, ... }: [
  (final: prev: {
    wezterm = inputs.nixpkgs-24-05.legacyPackages.${system}.wezterm;
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
