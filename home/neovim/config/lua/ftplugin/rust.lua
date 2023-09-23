vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "rust" },
  callback = function()
    local map = vim.keymap.set
    map("n", "<C-x><C-x>", "<CMD>RustRun<CR>", { buffer = true, noremap = true })
  end,
})
