vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "sh" },
  callback = function()
    local map = vim.keymap.set
    map("n", "Q", "<cmd>%!shfmt<CR>", { buffer = true, noremap = true })
    map({ "v", "x" }, "Q", "<esc><cmd>'<,'>!shfmt<cr>", { buffer = true, noremap = true })
  end,
})
