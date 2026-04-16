local map = vim.keymap.set
local M = {}

M.lsp_keymaps = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local border = require("general.themes").get_border_style()
  map({ "n", "v" }, "K", function()
    vim.lsp.buf.hover({ border = border })
  end, opts)
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
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

return M
