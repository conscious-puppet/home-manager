{ config, pkgs, ... }:
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

      # theme
      kanagawa-nvim

      nvim-colorizer-lua
      indent-blankline-nvim

      # git
      vim-fugitive
      diffview-nvim

      gitsigns-nvim
      vim-merginal

      # lsp
      fidget-nvim
      nvim-lspconfig
      nvim-lsp-ts-utils
      rust-tools-nvim
      # Diagnostics window
      trouble-nvim

      # Syntax highlighting
      nvim-treesitter.withAllGrammars
      nvim-ts-context-commentstring

      # Commenting
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }
      # Highlight selected symbol
      vim-illuminate

      # file tree
      nvim-web-devicons
      nvim-tree-lua
      {
        plugin = oil-nvim;
        type = "lua";
        config = "require('oil').setup()";
      }

      lualine-nvim
      nvim-navic
      barbecue-nvim

      {
        plugin = vim-easy-align;
        type = "lua";
        config = "vim.g.easy_align_ignore_groups = {}";
      }
      vim-table-mode
      vim-tmux-navigator

    ];

    extraPackages = with pkgs; [
      tree-sitter
      nodejs

      # Lua
      lua-language-server
      # Nix
      nil
      nixpkgs-fmt
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

    extraLuaConfig = ''
      require "general"
    '';
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}

