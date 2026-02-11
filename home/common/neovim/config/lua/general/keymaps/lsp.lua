local map = vim.keymap.set
local M = {}

M.lsp_keymaps = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map({ "n", "v" }, "K", vim.lsp.buf.hover, opts)
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "<leader>cl", vim.lsp.codelens.run, opts)

  if client.supports_method("textDocument/formatting") then
    map({ "n", "v" }, "Q", vim.lsp.buf.format, opts)
  end

  map("n", "<leader>r", vim.lsp.buf.rename, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "gl", vim.diagnostic.open_float, opts)
  map("n", "[e", vim.diagnostic.goto_prev, opts)
  map("n", "]e", vim.diagnostic.goto_next, opts)
end

return M
