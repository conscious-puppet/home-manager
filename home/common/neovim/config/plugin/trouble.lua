local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

trouble.setup({
  use_diagnostic_signs = true,
})

local map = vim.keymap.set
map("n", "<leader>d", "<cmd>Trouble diagnostics toggle filter.buf=0 <cr>", { noremap = true })
map("n", "<leader>D", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true })
