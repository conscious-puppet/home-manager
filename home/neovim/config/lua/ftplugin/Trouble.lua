vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Trouble" },
  callback = function()
    local set = vim.opt
    set.wrap = true
  end,
})
