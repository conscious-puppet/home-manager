{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    prefix = "C-Space";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      set -g status-style bg=default
      set -g status-left-length 25

      set -sg escape-time 5

      # set prefix to C-space
      set -g prefix C-Space
      unbind C-b
      bind-key C-Space send-prefix

      # choose sessions
      unbind s
      bind C-Space choose-session
      bind Space choose-session

      # split window vertically
      unbind %
      bind v split-window -h

      # split window horizontally
      unbind '"'
      bind s split-window -v

      # refresh tmux conf
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # clear screen and history
      bind C-k send-keys -R \; clear-history

      # resize tmux panes
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      bind -r H resize-pane -L 5

      # maximize current pane
      bind -r m resize-pane -Z

      # mouse support
      set -g mouse on

      # enable vi keys
      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
}

# for tpm
# git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# prefix +
# Shift-I  -  install plugins
# c        -  create a new window
# 0-9      -  switch to that window
# p        -  switch prev window
# n        -  switch next window
# ,        -  rename a window
# [        -  scroll mode
