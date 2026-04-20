local lualine_status_ok, lualine = pcall(require, "lualine")

if not lualine_status_ok then
  return
end

local uniform_theme = {
  normal = {
    a = "StatusLine",
    b = "StatusLine",
    c = "StatusLine",
  },
  insert = {
    a = "StatusLine",
    b = "StatusLine",
    c = "StatusLine",
  },
  visual = {
    a = "StatusLine",
    b = "StatusLine",
    c = "StatusLine",
  },
  replace = {
    a = "StatusLine",
    b = "StatusLine",
    c = "StatusLine",
  },
  command = {
    a = "StatusLine",
    b = "StatusLine",
    c = "StatusLine",
  },
  inactive = {
    a = "StatusLineNC",
    b = "StatusLineNC",
    c = "StatusLineNC",
  },
}

lualine.setup({
  options = {
    theme = uniform_theme,
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  winbar = {
    lualine_a = { { "filename", path = 1, padding = { left = 0, right = 1 } } },
  },
  inactive_winbar = {
    lualine_a = { { "filename", path = 1, padding = { left = 0, right = 1 } } },
  },
  sections = {
    lualine_a = { { "mode", padding = { left = 0, right = 1 } } },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diff",
        colored = false,
      },
    },
    lualine_x = {
      {
        "diagnostics",
        colored = false,
        symbols = {
          error = "E ",
          warn = "W ",
          info = "I ",
          hint = "H ",
        },
      },
      {
        "lsp_status",
        icon = "",
        symbols = {
          spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
          done = "",
          separator = " ",
        },
        show_name = true,
      },
    },
    lualine_y = {
      "encoding",
      { "progress", separator = " ", padding = { left = 0, right = 0 } },
      { "location", padding = { left = 0, right = 0 } },
    },
    lualine_z = {
      {
        function()
          local current = vim.fn.tabpagenr()
          local total = vim.fn.tabpagenr("$")
          return current .. "/" .. total
        end,
        padding = { left = 1, right = 0 },
      },
    },
  },
})

vim.api.nvim_set_hl(0, "WinBar", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "WinBarNC", { link = "StatusLineNC" })
