local map = vim.keymap.set

-- Fugitive git commands
map("n", "<leader>gg", "<cmd>tab G<cr>", { noremap = true })
map("n", "<leader>gb", "<cmd>silent MerginalToggle<cr>", { noremap = true })
map("n", "<leader>gB", "<cmd>G blame<cr>", { noremap = true })
