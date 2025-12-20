local opts = {
  on_attach = require("general.lsp.handlers").on_attach,
  capabilities = require("general.lsp.handlers").capabilities,
}

vim.lsp.enable("lua_ls")
vim.lsp.enable("hls")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("ccls")
vim.lsp.enable("pyright")

vim.lsp.config("ols", opts)
vim.lsp.enable("ols")

vim.lsp.config("rust_analyzer", opts)
vim.lsp.enable("rust_analyzer")
