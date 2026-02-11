return {
  on_attach = require("general.lsp").on_attach,
  capabilities = require("general.lsp").capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
