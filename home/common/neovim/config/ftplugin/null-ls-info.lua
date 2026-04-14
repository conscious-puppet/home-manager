vim.api.nvim_win_set_config(vim.api.nvim_get_current_win(), {
  border = require("general.themes").get_border_style(),
  height = 25,
})
