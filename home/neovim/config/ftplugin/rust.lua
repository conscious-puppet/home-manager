local map = vim.keymap.set
map("n", "<C-x><C-x>", "<CMD>RustRun<CR>", { buffer = true, noremap = true })
