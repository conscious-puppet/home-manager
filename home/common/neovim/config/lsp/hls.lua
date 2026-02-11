return {
  on_attach = require("general.lsp").on_attach,
  capabilities = require("general.lsp").capabilities,
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "fourmolu",
    },
  },
}
