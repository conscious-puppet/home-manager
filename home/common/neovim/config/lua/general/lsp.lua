local M = {}

M.setup = function()
  local themes = require("general.themes")
  
  -- Diagnostic configuration
  vim.diagnostic.config({
    signs = {
      text = { Error = "E", Warn = "W", Hint = "H", Info = "I" },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = true,
    float = {
      border = themes.get_border_style(),
      focusable = true,
      style = "minimal",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- LSP handler customization
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = themes.get_border_style() }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = themes.get_border_style() }
  )
end

return M
