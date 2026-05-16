local border = require("general.themes").get_border_style()

local override_capabilities = {
  ["ruff"] = {
    hoverProvider = false,
  },
  -- ["gopls"] = {
  --   documentFormatting = false,
  --   documentRangeFormatting = false,
  -- },
}

local function apply_override_capabilities(client)
  local caps = override_capabilities[client.name]
  if not caps then
    return
  end
  for cap, val in pairs(caps) do
    client.server_capabilities[cap] = val
  end
end

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
    apply_override_capabilities(client)
    require("general.keymaps.lsp").lsp_keymaps(client, args.buf)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config("*", { capabilities = capabilities })

-- Language server configurations
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("hls", {
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "fourmolu",
    },
  },
})

vim.lsp.config("ccls", {
  single_file_support = true,
})

vim.lsp.config("clangd", {
  cmd = { "clangd" },
})

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' },
      },
    },
  },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("hls")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("ccls")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
-- vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
vim.lsp.enable("ols")
vim.lsp.enable("rust_analyzer")
