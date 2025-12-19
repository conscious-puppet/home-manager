local opts = {
  on_attach = require("general.lsp.handlers").on_attach,
  capabilities = require("general.lsp.handlers").capabilities,
}

local lua_opts = vim.tbl_deep_extend("force", require("general.lsp.settings.lua_ls"), opts)
vim.lsp.config("lua_ls", lua_opts)
vim.lsp.enable("lua_ls")

local hls_opts = vim.tbl_deep_extend("force", require("general.lsp.settings.hls"), opts)
vim.lsp.config("hls", hls_opts)
vim.lsp.enable("hls")

vim.lsp.config("zls", opts)
vim.lsp.enable("zls")

vim.lsp.config("gopls", opts)
vim.lsp.enable("gopls")

local c_opts = vim.tbl_deep_extend("force", require("general.lsp.settings.ccls"), opts)

vim.lsp.config("ccls", c_opts)
vim.lsp.enable("ccls")

local pyright_opts = vim.tbl_deep_extend("force", require("general.lsp.settings.pyright"), opts)

vim.lsp.config("pyright", pyright_opts)
vim.lsp.enable("pyright")

vim.lsp.config("ols", opts)
vim.lsp.enable("ols")

vim.lsp.config("rust_analyzer", opts)
vim.lsp.enable("rust_analyzer")
