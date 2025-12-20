{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require("wezterm")
      local is_macos = wezterm.target_triple:find("apple") ~= nil

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      local merge_tbl = function(first_table, second_table)
        for k, v in pairs(second_table) do
          first_table[k] = v
        end
      end

      local keys = {}

      if is_macos then
        table.insert(keys, {
          key = "f",
          mods = "CMD|CTRL",
          action = wezterm.action.ToggleFullScreen,
        })

        config.native_macos_fullscreen_mode = true
      end

      merge_tbl(config, {
        color_scheme = "kanagawabones",
        font = wezterm.font_with_fallback({
          {
            family = "Iosevka",
          },
          {
            family = "Symbols Nerd Font Mono",
            scale = 0.6,
          },
        }),
        font_size = 21,
        line_height = 1.2,
        hide_tab_bar_if_only_one_tab = true,
        keys = keys,
        audible_bell = "Disabled",
      })

      return config
    '';
  };
}
