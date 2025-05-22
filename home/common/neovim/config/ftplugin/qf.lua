-- vim.cmd[[ nnoremap <buffer> <silent> dd
--   \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>]]

local map = vim.keymap.set
-- map("n", "dd", "<Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>", { buffer = true, noremap = true })
map(
  "n",
  "dd",
  "<Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')<CR>",
  { buffer = true, noremap = true }
)
