vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "nix" },
  callback = function()
    local map = vim.keymap.set
    map("n", "Q", "<cmd>%!nixpkgs-fmt<cr>", { buffer = true, noremap = true })
  end,
})
