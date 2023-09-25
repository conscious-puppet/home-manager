local config = require("general.lsp.settings.nvim-jdtls")

local status_ok, jdtls = pcall(require, "jdtls")
if status_ok then
  jdtls.start_or_attach(config)
end


-- local disable_codelens = vim.g.disable_codelens
-- disable_codelens.jdtls = true
-- vim.g.disable_formatting = disable_codelens
