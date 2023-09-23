vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "null-ls-info" },
  callback = function()
    vim.api.nvim_win_set_config(
      vim.api.nvim_get_current_win(), {
        border = vim.g.border_style,
        height = 25
      })
  end,
})
