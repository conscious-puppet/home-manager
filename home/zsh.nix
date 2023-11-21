{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      v = "nvim";
      vim = "nvim";
      # doom = "$HOME/.config/emacs/bin/doom";
      doom = "$HOME/.emacs.d/bin/doom";
      emacs = "emacs -nw";
      ls = "ls --color=auto";
      ll = "ls -A";
      la = "ls -lA";
      lla = "ls -lah";
      szrc = "source $HOME/.zshrc";
      pgres = "psql -d testdb -U bilbo";
      brew = "arch -arm64 /opt/homebrew/bin/brew";
      ibrew = "arch -x86_64 /usr/local/bin/brew";
      k = "microk8s kubectl";
      lsp-stash = "git update-index --no-skip-worktree cabal.project cabal.project.freeze && git restore cabal.project cabal.project.freeze";
      lsp-apply = "git update-index --skip-worktree cabal.project cabal.project.freeze";
      sshL = "ssh -L 127.0.0.1:5601:127.0.0.1:5601 -L 127.0.0.1:8013:127.0.0.1:8013 -L 127.0.0.1:3000:127.0.0.1:3000 -L 127.0.0.1:8081:127.0.0.1:8080";
      tmux = "tmux -u";
    };
    enableAutosuggestions = true;
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)               # Include hidden files.

      ec() {
        emacsclient -s $TMPDIR/emacs502/emacs-$1 "$@"
      }

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

      alias t="tmux -u attach || tmux -u new"
      p() {
        local dir
        local pdir=$(pwd)
        dir=$(
          cd &&
            fd -0 --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv |
            fzf --read0
        ) && cd ~/$dir
        local sessionname="$(basename -- $dir)"
        tmux -u new-session -A -s $sessionname
        cd $pdir
      }

      setup-dev() {
        tmux -u has-session -t=pgres 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s pgres -c ~/work
          tmux -u send-keys -t pgres "psql -d testdb -U bilbo" Enter "\x" Enter
        fi

        tmux -u has-session -t=redis-cli 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s redis-cli -c ~/work
          tmux -u send-keys -t redis-cli "redis-cli" Enter
        fi

        tmux -u has-session -t=ghci 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s ghci -c ~/work
          tmux -u send-keys -t ghci "ghci" Enter
        fi

        tmux -u has-session -t=npci-mocking 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s npci-mocking -c ~/work/npci-mocking/
          tmux -u send-keys -t npci-mocking "node app.js" Enter
        fi

        tmux -u has-session -t=newton-hs 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s newton-hs -c ~/work/newton-hs/
          tmux -u send-keys -t newton-hs "v" Enter
        fi
      }

      start-ngrok() {
        tmux -u has-session -t=ngrok 2>/dev/null
        if [ $? -ne 0 ]; then
          tmux -u new -d -s ngrok
          tmux -u send-keys -t ngrok "ngrok tcp 22" Enter "\x" Enter
        fi
      }

      flush-dev() {
        tmux -u has-session -t=pgres 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux -u kill-session -t pgres
        fi

        tmux -u has-session -t=redis-cli 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux -u kill-session -t redis-cli
        fi

        tmux -u has-session -t=ghci 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux -u kill-session -t ghci
        fi

        tmux -u has-session -t=npci-mocking 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux -u kill-session -t npci-mocking
        fi

        tmux -u has-session -t=newton-hs 2>/dev/null
        if [ $? -eq 0 ]; then
          tmux -u kill-session -t newton-hs
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
