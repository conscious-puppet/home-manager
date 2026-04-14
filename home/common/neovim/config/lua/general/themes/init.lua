local theme = require("general.themes.solarized")

-- Default single sharp borders
local default_borders = {
  style = "single",
  chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
}

local defaults = {
  set = function()
    vim.cmd.colorscheme("default")
  end,
  colors = "default",
  active_tab_color = "lualine_a_normal",
  inactive_tab_color = "lualine_a_active",
  fugitive_branch_bg = "none",
  fugitive_branch_fg = "none",
  diff_added_fg = "#1abc9c",
  diff_modified_fg = "#0db9d7",
  diff_removed_fg = "#db4b4b",
  borders = default_borders,
}

local M = vim.tbl_deep_extend("force", {}, defaults, theme or {})

-- Get border characters from theme or defaults
M.get_border_chars = function()
  return (M.borders and M.borders.chars) or default_borders.chars
end

-- Get border style from theme or defaults
M.get_border_style = function()
  return (M.borders and M.borders.style) or default_borders.style
end

return M

-- if theme == "moonfly" then
--   theme = require 'lualine.themes.moonfly'
--   theme.normal.c.bg = '#080808'
--   fugitive_branch_fg = theme.normal.a.fg
--   fugitive_branch_bg = theme.normal.a.bg
-- elseif theme == "onedark" then
--   theme = require 'lualine.themes.onedark'
--   theme.normal.a.gui = nil
--   theme.insert.a.gui = nil
--   theme.visual.a.gui = nil
--   theme.command.a.gui = nil
--   theme.terminal.a.gui = nil
--   theme.replace.a.gui = nil
--   theme.inactive.a.gui = nil
--   theme.normal.c.fg = '#798294'
--   theme.normal.c.bg = '#21252b'
--   active_buffers_color = "lualine_a_insert"
--   inactive_buffers_color = "lualine_c_normal"
--   fugitive_branch_fg = theme.normal.a.fg
--   fugitive_branch_bg = theme.normal.a.bg
-- end
