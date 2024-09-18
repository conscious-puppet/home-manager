local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")

if not status_ok_lspconfig then
  return
end

local opts = {
  on_attach = require("general.lsp.handlers").on_attach,
  capabilities = require("general.lsp.handlers").capabilities,
}


local lua_opts = vim.tbl_deep_extend("force",
  require("general.lsp.settings.lua_ls"),
  opts)
lspconfig.lua_ls.setup(lua_opts)

local hls_opts = vim.tbl_deep_extend("force",
  require("general.lsp.settings.hls"),
  opts)
lspconfig.hls.setup(hls_opts)

--   lspconfig.zls.setup(opts)

lspconfig.gopls.setup(opts)

local c_opts = vim.tbl_deep_extend("force",
  require("general.lsp.settings.ccls"),
  opts)

lspconfig.ccls.setup(c_opts)

local pyright_opts = vim.tbl_deep_extend("force",
  require("general.lsp.settings.pyright"),
  opts)

lspconfig.pyright.setup(pyright_opts)
