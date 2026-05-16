{ ... }:

{
  programs.zathura = {
    enable = true;

    options = {
      font = "Iosevka 14";

      default-bg = "#002b36";
      default-fg = "#839496";

      recolor = true;
      recolor-lightcolor = "#002b36";
      recolor-darkcolor = "#839496";

      statusbar-bg = "#002b36";
      statusbar-fg = "#839496";

      inputbar-bg = "#073642";
      inputbar-fg = "#eee8d5";

      highlight-color = "#0a4454";
      highlight-active-color = "#268bd2";
      highlight-fg = "#eee8d5";

      completion-group-bg = "#002b36";
      completion-group-fg = "#839496";
      completion-bg = "#073642";
      completion-fg = "#839496";
      completion-highlight-bg = "#586e75";
      completion-highlight-fg = "#eee8d5";

      notification-error-bg = "#073642";
      notification-error-fg = "#dc322f";
      notification-warning-bg = "#073642";
      notification-warning-fg = "#dc322f";
      notification-bg = "#073642";
      notification-fg = "#b58900";

      index-bg = "#002b36";
      index-fg = "#839496";
      index-active-bg = "#073642";
      index-active-fg = "#eee8d5";

      selection-clipboard = "clipboard";
      scroll-step = 50;
    };
  };
}
