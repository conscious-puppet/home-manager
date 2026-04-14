local keymaps = require("general.keymaps.lsp")

-- Shared on_attach function
vim.lsp.config("*", {
  on_attach = function(client, bufnr)
    keymaps.lsp_keymaps(client, bufnr)
  end,
})

-- Get capabilities (with CMP support)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

-- Enable servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("hls")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("ccls")
vim.lsp.enable("pyright")
vim.lsp.enable("ols")
vim.lsp.enable("rust_analyzer")
