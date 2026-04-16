vim.keymap.set({ "n", "v" }, "Q", function()
  require("conform").format()
end, { buffer = true, noremap = true })
