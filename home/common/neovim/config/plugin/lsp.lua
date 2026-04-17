local border = require("general.themes").get_border_style()

vim.lsp.config("*", {
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers["textDocument/hover"], {
      border = border,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["textDocument/signatureHelp"], {
      border = border,
    }),
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    require("general.keymaps.lsp").lsp_keymaps(client, args.buf)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable("lua_ls")
vim.lsp.enable("hls")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("ccls")
vim.lsp.enable("pyright")
vim.lsp.enable("ols")
vim.lsp.enable("rust_analyzer")
