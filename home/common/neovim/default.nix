{ self, inputs, config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      # Completions
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-cmp

      # Snippets
      luasnip
      cmp_luasnip

      telescope-nvim
      telescope-fzf-native-nvim

      # theme
      kanagawa-nvim
      nvim-solarized-lua

      nvim-colorizer-lua
      indent-blankline-nvim

      # git
      vim-fugitive
      diffview-nvim

      gitsigns-nvim
      vim-merginal

      # lsp
      nvim-lspconfig

      # Diagnostics window
      trouble-nvim
      conform-nvim

      # Syntax highlighting
      nvim-treesitter.withAllGrammars
      vim-just
      Jenkinsfile-vim-syntax

      # Commenting
      comment-nvim
      # Highlight selected symbol
      vim-illuminate

      # file tree
      nvim-web-devicons
      nvim-tree-lua
      oil-nvim

      lualine-nvim

      vim-easy-align

      vim-table-mode
      vim-tmux-navigator
    ];

    extraPackages = with pkgs; [
      # Lua
      lua-language-server
      # Nix
      nil
      nixfmt
      statix
      # sh
      shfmt
      # json
      jq
      # Python
      pyright
      black
      # Typescript
      nodePackages.typescript-language-server
      # Web (ESLint, HTML, CSS, JSON)
      nodePackages.vscode-langservers-extracted

      # Telescope tools
      ripgrep
      fd
    ];

  };

  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/home/common/neovim/config";
  # home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./config;
}

