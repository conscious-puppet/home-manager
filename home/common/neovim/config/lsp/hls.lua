return {
  on_attach = require("general.lsp.handlers").on_attach,
  capabilities = require("general.lsp.handlers").capabilities,
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "fourmolu",
    },
  },
}
