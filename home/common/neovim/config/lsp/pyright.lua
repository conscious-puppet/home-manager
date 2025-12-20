return {
  on_attach = require("general.lsp.handlers").on_attach,
  capabilities = require("general.lsp.handlers").capabilities,
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
