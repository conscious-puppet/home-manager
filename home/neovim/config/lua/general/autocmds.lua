-- local cmd = vim.api.nvim_create_autocmd

vim.cmd [[
  au BufNewFile,BufRead *.log  :setl ft=log
  au BufNewFile,BufRead *.purs :setl ft=purescript
  autocmd BufEnter,BufRead * normal zR
]]



vim.cmd [[
  augroup neovim_terminal
      autocmd!
      " Enter Terminal-mode (insert) automatically
      autocmd TermOpen * startinsert
      " Disables number lines on terminal buffers
      autocmd TermOpen * :set nonumber norelativenumber
      " allows you to use Ctrl-c on terminal window
      autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
      autocmd TermClose zsh call feedkeys("i")
  augroup END
]]

-- autocmd BufReadPost,FileReadPost * normal zR
-- au BufNewFile,BufRead *.log :setl ft=json



-- local api = vim.api
-- local M = {}
-- -- function to create a list of commands and convert them to autocommands
-- -------- This function is taken from https://github.com/norcalli/nvim_utils
-- function M.nvim_create_augroups(definitions)
--     for group_name, definition in pairs(definitions) do
--         api.nvim_command('augroup '..group_name)
--         api.nvim_command('autocmd!')
--         for _, def in ipairs(definition) do
--             local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--             api.nvim_command(command)
--         end
--         api.nvim_command('augroup END')
--     end
-- end
--
--
-- local autoCommands = {
--     -- other autocommands
--     open_folds = {
--         {"BufReadPost,FileReadPost", "*", "normal zR"}
--     }
-- }
--
-- M.nvim_create_augroups(autoCommands)
--
-- return M

