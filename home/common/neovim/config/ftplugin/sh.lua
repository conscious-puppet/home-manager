vim.keymap.set({ "n", "v" }, "Q", function()
  require("conform").format({ lsp_fallback = true })
end, { buffer = true, noremap = true })
