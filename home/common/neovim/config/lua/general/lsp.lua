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

  -- LSP signature help border (Neovim 0.11+)
  -- Note: hover border is set in keymaps/lsp.lua (buffer-local, per client attach)
  local border = themes.get_border_style()
  vim.keymap.set("n", "<C-k>", function()
    vim.lsp.buf.signature_help({ border = border })
  end, { desc = "LSP Signature Help" })
end

return M
