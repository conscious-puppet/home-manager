local M = {}

-- Border configuration for this theme
M.borders = {
  style = "single",
  chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
}

-- Dim border/separator color (base02)
M.border_fg = "#073642"

-- StatusLine colors (no background)
M.statusline_colors = {
  normal = { fg = "#839496", bg = nil }, -- base0, transparent
  nc = { fg = "#586e75", bg = nil }, -- base01, transparent
}

M.set = function()
  -- Solarized Lua theme settings
  vim.g.solarized_italics = 1
  vim.g.solarized_borders = 1

  local theme_set, _ = pcall(vim.cmd.colorscheme, "solarized")

  if theme_set then
    vim.api.nvim_set_hl(0, "StatusLine", M.statusline_colors.normal)
    vim.api.nvim_set_hl(0, "StatusLineNC", M.statusline_colors.nc)
    vim.api.nvim_set_hl(0, "Visual", { bg = "#0a4454", default = false })
    vim.api.nvim_set_hl(0, "SignColumn", { link = "LineNr", default = false })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = M.border_fg, bg = nil, default = false })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", default = false })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = M.border_fg, bg = "NONE", default = false })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder", default = false })
    vim.api.nvim_set_hl(0, "IblIndent", { fg = M.border_fg, bg=nil, default = false }) -- Indent Blankline
    vim.api.nvim_set_hl(0, "IncSearch", { link = "Search", default = false })
  end
end

return M
