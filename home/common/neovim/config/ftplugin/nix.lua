local map = vim.keymap.set
map("n", "Q", "<cmd>%!nixpkgs-fmt<cr>", { buffer = true, noremap = true })
