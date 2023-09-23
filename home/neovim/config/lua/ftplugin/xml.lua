vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "xml" },
  callback = function()
    local map = vim.keymap.set

    map("n", "Q", "<cmd>%!xmllint --format -<CR>", { buffer = true, noremap = true })
    map({ "v", "x" }, "Q", "<esc><cmd>'<,'>!xmllint --format -<cr>", { buffer = true, noremap = true })
  end,
})
