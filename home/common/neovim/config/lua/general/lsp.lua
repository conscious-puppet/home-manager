local M = {}
local keymaps = require("general.keymaps.lsp")

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "ﴞ" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    signs = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = true,
    float = {
      border = vim.g.border_style,
      focusable = true,
      style = "minimal",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = vim.g.border_style })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = vim.g.border_style })
end

M.on_attach = function(client, bufnr)
  keymaps.lsp_keymaps(client, bufnr)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {buf = bufnr})
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
