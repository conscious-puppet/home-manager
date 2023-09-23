vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "fugitiveblame" },
  callback = function()
    vim.opt_local.winbar = "Fugitive Blame"
  end,
})
