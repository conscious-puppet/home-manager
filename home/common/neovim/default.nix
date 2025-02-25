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
      nvim-jdtls

      # Diagnostics window
      trouble-nvim
      # nvim-calltree
      conform-nvim

      # Syntax highlighting
      nvim-treesitter.withAllGrammars
      vim-just # just file support, mostly for syntax highlighting
      Jenkinsfile-vim-syntax

      # Commenting
      # nvim-ts-context-commentstring
      comment-nvim
      # Highlight selected symbol
      vim-illuminate

      # file tree
      nvim-web-devicons
      nvim-tree-lua
      oil-nvim

      lualine-nvim
      nvim-navic
      barbecue-nvim

      vim-easy-align

      vim-table-mode
      vim-tmux-navigator

      # ui
      # neophyte-nvim
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

      # for mkdnflow-nvim
      luajitPackages.luautf8

      # java language server
      jdt-language-server
      lombok
    ];

  };

  home.sessionVariables.NVIM_JDT_LANGUAGE_SERVER = "${pkgs.jdt-language-server}/bin/jdt-language-server";
  home.sessionVariables.NVIM_LOMBOK_JAR = "${pkgs.lombok}/share/java/lombok.jar";

  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/home/common/neovim/config";
  # home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./config;
}

