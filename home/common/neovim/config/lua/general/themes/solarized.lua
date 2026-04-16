local M = {}

-- Border configuration for this theme
M.borders = {
  style = "single",
  chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
}

-- StatusLine colors (dimmed solarized palette)
M.statusline_colors = {
  normal = { fg = "#839496", bg = "#073642" }, -- base0 on base02
  nc = { fg = "#586e75", bg = "#002b36" }, -- base01 on base03
}

M.set = function()
  -- Solarized Lua theme settings
  vim.g.solarized_italics = 1
  vim.g.solarized_borders = 1

  local theme_set, _ = pcall(vim.cmd.colorscheme, "solarized")

  if theme_set then
    vim.api.nvim_set_hl(0, "StatusLine", M.statusline_colors.normal)
    vim.api.nvim_set_hl(0, "StatusLineNC", M.statusline_colors.nc)
    vim.api.nvim_set_hl(0, "SignColumn", { link = "LineNr", default = false })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = M.statusline_colors.normal.bg, bg = nil, default = false })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = M.statusline_colors.normal.bg, bg = nil, default = false })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder", default = false })
    vim.api.nvim_set_hl(0, "IblIndent", { link = "WinSeparator", default = false }) -- Indent Blankline
  end
end

return M
