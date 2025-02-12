{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require("wezterm")

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

      -- This is where you actually apply your config choices

      -- For example, changing the color scheme:

      local keys = {
        {
          key = "f",
          mods = "CMD|CTRL",
          action = wezterm.action.ToggleFullScreen,
        },
      }

      -- print(wezterm.color.get_builtin_schemes())

      merge_tbl(config, {
        -- color_scheme = "Wryan",
        -- color_scheme = "Green Screen (base16)",
        -- color_scheme = "GruvboxDark",
        -- color_scheme = "VSCodeDark+ (Gogh)",
        color_scheme = "kanagawabones",
        -- font = wezterm.font("JetBrains Mono"),
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
        native_macos_fullscreen_mode = true,
        keys = keys,
        audible_bell = "Disabled",
      })

      -- and finally, return the configuration to wezterm
      return config
    '';
  };
}
