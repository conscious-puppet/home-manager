# Edit this to install packages and modify dotfile configuration in your
# $HOME.
#
# https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
{ pkgs, ... }: {
  # imports = [
  #   # This loads ./home/neovim/default.nix - neovim configured for Haskell dev, and other things.
  #   ./home/neovim
  #   # Add more of your home-manager modules here.
  # ];

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    nix-output-monitor # https://github.com/maralorn/nix-output-monitor
    nix-info
    cachix
    lazygit # Better git UI
    ripgrep # Better `grep`
    nil # Nix language server
    shfmt
    nixpkgs-fmt
    tmux
    tmate
    jq
    fzf
    wezterm
    nodejs
    neovim
    # lapce
    # meld
    raycast
    graphviz
    watch
    gnuplot
  ];

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

  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "nvim";
      vim = "nvim";
      doom = "$HOME/.config/emacs/bin/doom";
      ls = "ls --color=auto";
      ll = "ls -A";
      la = "ls -lA";
      lla = "ls -lah";
      szrc = "source $HOME/.zshrc";
      pgres = "psql -d testdb -U bilbo";
      brew = "arch -arm64 /opt/homebrew/bin/brew";
      ibrew = "arch -x86_64 /usr/local/bin/brew";
      k = "kubectl";
      lsp-stash = "git update-index --no-skip-worktree cabal.project cabal.project.freeze && git restore cabal.project cabal.project.freeze";
      lsp-apply = "git update-index --skip-worktree cabal.project cabal.project.freeze";
    };
    enableAutosuggestions = true;
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)               # Include hidden files.

      killport() {
          kill -9 $(lsof -ti:$1)
      }

      link-psql12() {
        arch -arm64 /opt/homebrew/bin/brew unlink postgresql@14
        arch -arm64 /opt/homebrew/bin/brew services stop postgresql@14
        arch -x86_64 /usr/local/bin/brew link postgresql@12
        arch -x86_64 /usr/local/bin/brew services start postgresql@12

        arch -arm64 /opt/homebrew/bin/brew servies start redis
      }

      link-psql14() {
        arch -x86_64 /usr/local/bin/brew unlink postgresql@12
        arch -x86_64 /usr/local/bin/brew services stop postgresql@12
        arch -arm64 /opt/homebrew/bin/brew link postgresql@14
        arch -arm64 /opt/homebrew/bin/brew services start postgresql@14

        arch -arm64 /opt/homebrew/bin/brew services start redis
      }

      stop-psql() {
        arch -arm64 /opt/homebrew/bin/brew unlink postgresql@14
        arch -arm64 /opt/homebrew/bin/brew services stop postgresql@14
        arch -x86_64 /usr/local/bin/brew unlink postgresql@12
        arch -x86_64 /usr/local/bin/brew services stop postgresql@12

        arch -arm64 /opt/homebrew/bin/brew services stop redis
      }

      # backward search
      bindkey "^R" history-incremental-search-backward

      # fzf
      f() {
        local dir
        dir=$(
          cd &&
            fd -0 --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv |
            fzf --read0
        ) && cd ~/$dir
      }

      alias t="tmux attach || tmux new"
      p() {
        local dir
        local pdir=$(pwd)
        dir=$(
          cd &&
            fd -0 --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv |
            fzf --read0
        ) && cd ~/$dir
        local sessionname="$(basename -- $dir)"
        tmux new-session -A -s $sessionname
        cd $pdir
      }

      setup-dev() {
        tmux has-session -t=pgres 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux new -d -s pgres -c ~/work
          tmux send-keys -t pgres "psql -d testdb -U bilbo" Enter "\x" Enter
        fi

        tmux has-session -t=redis-cli 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux new -d -s redis-cli -c ~/work
          tmux send-keys -t redis-cli "redis-cli" Enter
        fi

        tmux has-session -t=ghci 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux new -d -s ghci -c ~/work
          tmux send-keys -t ghci "ghci" Enter
        fi

        tmux has-session -t=npci-mocking 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux new -d -s npci-mocking -c ~/work/npci-mocking/
          tmux send-keys -t npci-mocking "node app.js" Enter
        fi

        tmux has-session -t=newton-hs 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux new -d -s newton-hs -c ~/work/newton-hs/
          tmux send-keys -t newton-hs "v" Enter
        fi
      }

      flush-dev() {
        tmux has-session -t=pgres 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux kill-session -t pgres
        fi

        tmux has-session -t=redis-cli 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux kill-session -t redis-cli
        fi

        tmux has-session -t=ghci 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux kill-session -t ghci
        fi

        tmux has-session -t=npci-mocking 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux kill-session -t npci-mocking
        fi

        tmux has-session -t=newton-hs 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux kill-session -t newton-hs
        fi
      }

      vimrc() {
        local dir=$(pwd)
        local nvim_dir="$HOME/.config/nvim"
        cd $nvim_dir
        nvim
        # $EDITOR
        cd $dir
      }


      [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
    '';
    envExtra = ''
      PATH="/usr/local/sbin:$PATH"
      PATH="/opt/homebrew/bin:$PATH"
      PATH="$HOME/.ghcup/bin:$PATH"
      PATH="$HOME/.local/bin:$PATH"
      PATH="/usr/local/opt/llvm@12/bin:$PATH"

      export PATH
      export EDITOR='nvim'
      export VISUAL='nvim'
      # Make Nix and home-manager installed things available in PATH.
      export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
    '';
  };
}
