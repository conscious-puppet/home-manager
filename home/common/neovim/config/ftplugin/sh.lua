local map = vim.keymap.set
map("n", "Q", "<cmd>%!shfmt<CR>", { buffer = true, noremap = true })
map({ "v", "x" }, "Q", "<esc><cmd>'<,'>!shfmt<cr>", { buffer = true, noremap = true })
